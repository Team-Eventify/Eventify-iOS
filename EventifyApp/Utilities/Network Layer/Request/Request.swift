//
//  Request.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Основной класс запросов
class Request {
    /// Максимальное количество попыток обновления токена
    private let maxTokenRefreshAttempts = 3
    
    /// Отправляет запросы в сеть
    /// - Parameters:
    ///   - endpoint: конечная точка запроса
    ///   - responseModel: модель ответа
    ///   - urlEncoded: флаг для URL-кодирования
    ///   - tokenRefreshCount: счетчик попыток обновления токена
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

        if let accessToken = KeychainManager.shared.get(key: KeychainKeys.accessToken) {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            print("🔐 Access Token added to request: \(accessToken)")
        } else {
            print("⚠️ No access token found in Keychain")
        }
        
        print("🛫 Request Headers: \(request.allHTTPHeaderFields ?? [:])")

        if let body = endpoint.parameters {
            switch endpoint.method {
            case .get:
                var urlComponents = URLComponents(string: API.baseURL + endpoint.path)
                urlComponents?.queryItems = body.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                request.url = body.count > 0 ? urlComponents?.url : URL(string: API.baseURL + endpoint.path)
            case .post, .put, .patch:
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
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
                    let decodedResponse = try decoder.decode(responseModel, from: data)
                    return decodedResponse
                } catch {
                    print("Decoding Error: \(error)")
                    throw RequestError.decode
                }
            case 400:
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("400 Error: \(errorMessage)")
                throw RequestError.unexpectedStatusCode
            case 401:
                print("🔄 Starting token refresh")
                do {
                    let tokenResponse = try await TokenService.shared.refreshTokens()
                    print("🔐 Token Response: \(tokenResponse)")
                    KeychainManager.shared.set(tokenResponse.accessToken, key: KeychainKeys.accessToken)
                    KeychainManager.shared.set(tokenResponse.refreshToken, key: KeychainKeys.refreshToken)
                    
                    print("🔑 New Access Token: \(tokenResponse.accessToken)")
                    
                    // Создаем новый эндпоинт с обновленными заголовками
                    let newEndpoint = RefreshedEndpoint(original: endpoint, newToken: tokenResponse.accessToken)
                    
                    print("🔁 Retrying request with new token")
                    // Отправляем запрос с обновленным эндпоинтом
                    return try await sendRequest(
                        endpoint: newEndpoint,
                        responseModel: responseModel,
                        urlEncoded: urlEncoded
                    )
                } catch {
                    print("❌ Error during token refresh: \(error)")
                    throw RequestError.tokenRefreshFailed
                }
            default:
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("Unexpected Error: \(errorMessage)")
                throw RequestError.unknown
            }
                
        } catch {
            if let requestError = error as? RequestError,
               case .unexpectedStatusCode = requestError {
                throw RequestError.authentinticationFailed
            }
            throw error
        }
    }
}

/// Обертка для обновленного эндпоинта
struct RefreshedEndpoint: Endpoint {
    private let original: Endpoint
    private let newToken: String
    
    var path: String { original.path }
    var method: RequestMethod { original.method }
    var parameters: [String: Any]? { original.parameters }
    
    var header: [String: String]? {
        var updatedHeader = original.header ?? [:]
        updatedHeader["Authorization"] = "Bearer \(newToken)"
        return updatedHeader
    }
    
    init(original: Endpoint, newToken: String) {
        self.original = original
        self.newToken = newToken
    }
}
