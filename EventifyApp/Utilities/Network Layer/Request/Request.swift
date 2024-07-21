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

		if let body = endpoint.parameters {
			switch endpoint.method {
			case .get:
				var urlComponents = URLComponents(string: API.baseURL + endpoint.path)
				urlComponents?.queryItems = body.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
				request.url = body.count > 0 ? urlComponents?.url : URL(string: API.baseURL + endpoint.path)
			case .post:
				request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
				request.addValue("application/json", forHTTPHeaderField: "Content-Type")
				request.addValue("application/json", forHTTPHeaderField: "Accept")
			}
		}

		let (data, response) = try await URLSession.shared.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse else {
			throw RequestError.noResponse
		}

		print("HTTP Status Code: \(httpResponse.statusCode)")

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
		default:
			let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
			print("Unexpected Error: \(errorMessage)")
			throw RequestError.unknown
		}
	}
}
