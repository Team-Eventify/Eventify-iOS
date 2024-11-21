//
//  Request.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

class Request {
	private let maxTokenRefreshAttempts = 3

	func sendRequest<T: Decodable>(
		endpoint: Endpoint,
		responseModel: T.Type,
		urlEncoded: Bool = false,
		tokenRefreshCount: Int = 0
	) async throws -> T {
		let request = try createURLRequest(for: endpoint)
		
		do {
			let (data, response) = try await URLSession.shared.data(for: request)
			return try await handleResponse(
				data: data,
				response: response,
				responseModel: responseModel,
				endpoint: endpoint,
				urlEncoded: urlEncoded,
				tokenRefreshCount: tokenRefreshCount
			)
		} catch {
			throw error
		}
	}

	// Helper function to create URLRequest
	private func createURLRequest(for endpoint: Endpoint) throws -> URLRequest {
		guard let url = URL(string: API.baseURL + endpoint.path) else {
			throw RequestError.invalidURL
		}

		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		request.allHTTPHeaderFields = endpoint.header

		if endpoint.addAuthorizationToken {
			addAuthorizationToken(to: &request)
		}

		if let body = endpoint.parameters {
			try addRequestBody(to: &request, method: endpoint.method, body: body, endpoint: endpoint)
		}

		return request
	}

	// Helper function to add authorization token
	private func addAuthorizationToken(to request: inout URLRequest) {
		if let accessToken = KeychainManager.shared.get(key: KeychainKeys.accessToken) {
			request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
			Logger.log(level: .network, "Auth Token: \(accessToken)")
		} else {
			Logger.log(level: .warning, "No access token found in Keychain")
		}
	}

	// Helper function to add request body
	private func addRequestBody(to request: inout URLRequest, method: RequestMethod, body: [String: Any], endpoint: Endpoint) throws {
		switch method {
		case .get:
			var urlComponents = URLComponents(string: API.baseURL + endpoint.path)
			urlComponents?.queryItems = body.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
			request.url = body.count > 0 ? urlComponents?.url : URL(string: API.baseURL + endpoint.path)
		case .post, .put, .patch:
			if let categoriesArray = body["categories"] as? [String], endpoint is CategoriesEndpoint {
				request.httpBody = try? JSONSerialization.data(withJSONObject: categoriesArray, options: [])
			} else {
				request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
			}
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("application/json", forHTTPHeaderField: "Accept")
		}
	}

	// Helper function to handle response
	private func handleResponse<T: Decodable>(data: Data, response: URLResponse, responseModel: T.Type, endpoint: Endpoint, urlEncoded: Bool, tokenRefreshCount: Int) async throws -> T {
		guard let httpResponse = response as? HTTPURLResponse else {
			throw RequestError.noResponse
		}

		Logger.log(level: .info, "📋 HTTP Status Code: \(httpResponse.statusCode)")

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase

		switch httpResponse.statusCode {
		case 200...299:
			return try decodeResponse(data: data, responseModel: responseModel)
		case 401:
			return try await handleTokenRefresh(endpoint: endpoint, responseModel: responseModel, urlEncoded: urlEncoded, tokenRefreshCount: tokenRefreshCount)
		default:
			let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
			Logger.log(level: .error(), errorMessage)
			throw RequestError.unknown
		}
	}

	// Helper function to decode response
	private func decodeResponse<T: Decodable>(data: Data, responseModel: T.Type) throws -> T {
		if data.isEmpty {
			if responseModel is SetUserCategoriesModel.Type {
				return SetUserCategoriesModel() as! T
			} else {
				throw RequestError.emptyResponse
			}
		}

		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(responseModel, from: data)
		} catch {
			Logger.log(level: .error(error), "Decoding Error")
			throw RequestError.decode
		}
	}

	// Helper function to handle token refresh
	private func handleTokenRefresh<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, urlEncoded: Bool, tokenRefreshCount: Int) async throws -> T {
		if tokenRefreshCount >= maxTokenRefreshAttempts {
			throw RequestError.maxTokenRefreshAttemptsReached
		}

		do {
			try await Task.sleep(nanoseconds: 1_000_000_000)
			let tokenResponse = try await TokenService.shared.refreshTokens()

			guard
				KeychainManager.shared.set(tokenResponse.accessToken, key: KeychainKeys.accessToken),
				KeychainManager.shared.set(tokenResponse.refreshToken, key: KeychainKeys.refreshToken)
			else {
				throw RequestError.tokenSaveFailed
			}

			let newEndpoint = RefreshedEndpoint(original: endpoint, newToken: tokenResponse.accessToken)
			
			Logger.log(level: .network, "🔁 Retrying request with new token")
			return try await sendRequest(
				endpoint: newEndpoint,
				responseModel: responseModel,
				urlEncoded: urlEncoded,
				tokenRefreshCount: tokenRefreshCount + 1
			)
		} catch {
			Logger.log(level: .error(error), "Error during token refresh")
			throw RequestError.tokenRefreshFailed
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
