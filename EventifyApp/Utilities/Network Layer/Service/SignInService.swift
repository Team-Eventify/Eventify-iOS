//
//  SignInService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Протокол сервиса входа в приложение
protocol SignInServiceProtocol {

	/// Вход в приложение
	/// - Parameter json: данные в формате запроса
	/// - Returns: ответ от сервера
	func signIn(json: JSON) async throws -> SignInResponse
}

/// Сервис входа в приложение
final class SignInService: Request, SignInServiceProtocol {
	func signIn(json: JSON) async throws -> SignInResponse {
		return try await sendRequest(
			endpoint: SignInEndpoint.signIn(json: json),
			responseModel: SignInResponse.self
		)
	}
}

/// Модель ответа сервера
struct SignInResponse: Decodable {
	/// токен авторизационный
	let accessToken: String

	/// Обновляемый токен
	let refreshToken: String
}
