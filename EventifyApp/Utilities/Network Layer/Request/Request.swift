//
//  Request.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

class Request {

    private let maxTokenRefreshAttempts = 3

    let session = URLSession.shared

    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        urlEncoded: Bool = false,
        tokenRefreshCount: Int = 0
    ) async throws -> T {
        guard let url = URL(string: API.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if endpoint.addAuthorizationToken {
            if let accessToken = KeychainManager.shared.get(
                key: KeychainKeys.accessToken)
            {
                request.setValue(
                    "Bearer \(accessToken)", forHTTPHeaderField: "Authorization"
                )
            } else {
                Log.warning("No access token found in Keychain")
            }
        }

        if let body = endpoint.parameters {
            switch endpoint.method {
            case .get:
                var urlComponents = URLComponents(
                    string: API.baseURL + endpoint.path)
                urlComponents?.queryItems = body.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                request.url =
                    body.count > 0
                    ? urlComponents?.url
                    : URL(string: API.baseURL + endpoint.path)
            case .post, .put, .patch:
                if let categoriesArray = body["categories"] as? [String],
                    endpoint is CategoriesEndpoint
                {
                    // Особая обработка для массива категорий
                    request.httpBody = try? JSONSerialization.data(
                        withJSONObject: categoriesArray, options: [])
                } else {
                    // Стандартная обработка для остальных случаев
                    request.httpBody = try? JSONSerialization.data(
                        withJSONObject: body, options: [])
                }
                request.setValue(
                    "application/json", forHTTPHeaderField: "Content-Type")
                request.setValue(
                    "application/json", forHTTPHeaderField: "Accept")
            }
        }

        do {
			// TODO: - Сменить urlSession после тестов и убрать пункт с консолью pulse
			let (data, response) = try await session.data(
                for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }

			Log.network("📋 HTTP Status Code: \(httpResponse.statusCode)")

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            switch httpResponse.statusCode {
            case 200...299:
                do {
                    if data.isEmpty {
                        if responseModel is SetUserCategoriesModel.Type {
                            // Если ответ пустой и мы ожидаем SetUserCategoriesModel, возвращаем пустой экземпляр
                            return SetUserCategoriesModel() as! T
                        } else {
                            throw RequestError.emptyResponse
                        }
                    }
                    let decodedResponse = try decoder.decode(
                        responseModel, from: data)
                    return decodedResponse
                } catch {
                    Log.error("Decoding Error", error: error)
                    throw RequestError.decode
                }
            case 401:
                if tokenRefreshCount >= maxTokenRefreshAttempts {
                    throw RequestError.maxTokenRefreshAttemptsReached
                }

                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    let tokenResponse = try await TokenService.shared.refreshTokens()

                    guard
                        KeychainManager.shared.set(
                            tokenResponse.accessToken,
                            key: KeychainKeys.accessToken),
                        KeychainManager.shared.set(
                            tokenResponse.refreshToken,
                            key: KeychainKeys.refreshToken)
                    else {
                        throw RequestError.tokenSaveFailed
                    }

                    let newEndpoint = RefreshedEndpoint(
                        original: endpoint, newToken: tokenResponse.accessToken)

					Log.network("🔁 Retrying request with new token")
                    return try await sendRequest(
                        endpoint: newEndpoint,
                        responseModel: responseModel,
                        urlEncoded: urlEncoded,
                        tokenRefreshCount: tokenRefreshCount + 1
                    )
                } catch {
                    Log.error("Error during token refresh", error: error)
                    throw RequestError.tokenRefreshFailed
                }
            default:
                let errorMessage =
                    String(data: data, encoding: .utf8) ?? "Unknown error"
                Log.error("Unexpected Error: \(errorMessage)")
                throw RequestError.unknown
            }
        } catch {
            throw error
        }
    }
}

struct RefreshedEndpoint: Endpoint {
    private let original: Endpoint
    private let newToken: String

    var path: String { original.path }
    var method: RequestMethod { original.method }
    var parameters: [String: Any]? { original.parameters }

    var header: [String: String]? {
        ["Authorization": "Bearer \(newToken)"]
    }

    var addAuthorizationToken: Bool { return true }

    init(original: Endpoint, newToken: String) {
        self.original = original
        self.newToken = newToken
    }
}
