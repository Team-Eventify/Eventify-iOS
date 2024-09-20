//
//  RegistrationRequest.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Протокол сервиса входа
protocol SignUpServiceProtocol {

	/// Вход в приложение
	/// - Parameter json: данные в формате json
	/// - Returns: ответ от сервера
	func signUp(json: JSON) async throws -> SignUpResponse
}

/// Сервис входа в приложение
final class SignUpService: Request, SignUpServiceProtocol {
	func signUp(json: JSON) async throws -> SignUpResponse {
		return try await sendRequest(
			endpoint: SignUpEndpoint.signUp(json: json),
			responseModel: SignUpResponse.self
		)
	}
}

/// Модель ответа от сервера
struct SignUpResponse: Decodable {
    /// ID юзера
    let userId: String
	
    /// Токен доступа
	let accessToken: String

	/// Обновляемый токен
	let refreshToken: String
}
