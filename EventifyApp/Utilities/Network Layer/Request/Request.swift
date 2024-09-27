//
//  Request.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Основной класс запросов
class Request {
    /// Отправляет запросы в сеть
    /// - Parameters:
    ///   - endpoint: конечная точка запроса
    ///   - responseModel: модель ответа
    /// - Returns: данные из сети
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        urlEncoded: Bool = false
    ) async throws -> T {
        guard let url = URL(string: API.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }

        print("Request URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let accessToken = KeychainManager.shared.get(
            key: KeychainKeys.accessToken) {
            request.addValue(
                "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        print("🛫 Request Headers: \(request.allHTTPHeaderFields ?? [:])")

        if let body = endpoint.parameters {
            switch endpoint.method {
            case .get:
                var urlComponents = URLComponents(
                    string: API.baseURL + endpoint.path)
                urlComponents?.queryItems = body.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                request.url = body.count > 0
                    ? urlComponents?.url
                    : URL(string: API.baseURL + endpoint.path)
            case .post, .put, .patch:
                request.httpBody = try? JSONSerialization.data(
                    withJSONObject: body, options: [])
                request.addValue(
                    "application/json", forHTTPHeaderField: "Content-Type")
                request.addValue(
                    "application/json", forHTTPHeaderField: "Accept")
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(
                for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }

            print("📋 HTTP Status Code: \(httpResponse.statusCode)")
            print("🛬 Response Headers: \(httpResponse.allHeaderFields)")

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try decoder.decode(
                        responseModel, from: data)
                    return decodedResponse
                } catch {
                    print("Decoding Error: \(error)")
                    throw RequestError.decode
                }
            case 400:
                let errorMessage =
                    String(data: data, encoding: .utf8) ?? "Unknown error"
                print("400 Error: \(errorMessage)")
                throw RequestError.unexpectedStatusCode
            case 401:
                // Попытка обновить токен и повторить запрос
                let tokenResponse = try await TokenService.shared.refreshTokens()
                KeychainManager.shared.set(
                    tokenResponse.accessToken, key: KeychainKeys.accessToken)
                KeychainManager.shared.set(
                    tokenResponse.refreshToken, key: KeychainKeys.refreshToken)
                // Рекурсивный вызов для повторения запроса с новым токеном
                return try await sendRequest(
                    endpoint: endpoint, responseModel: responseModel,
                    urlEncoded: urlEncoded)
            default:
                let errorMessage =
                    String(data: data, encoding: .utf8) ?? "Unknown error"
                print("Unexpected Error: \(errorMessage)")
                throw RequestError.unknown
            }
        } catch {
            if let requestError = error as? RequestError,
                case .unexpectedStatusCode = requestError
            {
                throw RequestError.authentinticationFailed
            }
            throw error
        }
    }
}
