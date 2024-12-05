//
//  NewSignUpService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//

import Foundation
import Moya

protocol AuthServiceProtocol {
	func signUp(request: SignUpRequest) async throws -> AuthResponse
	func signIn(request: SignInRequest) async throws -> AuthResponse
}

final class AuthService: AuthServiceProtocol {
	private let provider = MoyaProvider<API.AuthEndpoints>(plugins: [NetworkLoggerPlugin()])
	
	func signUp(request: SignUpRequest) async throws -> AuthResponse {
		return try await withCheckedThrowingContinuation { continuation in
			provider.request(.signUp(request: request)) { result in
				switch result {
					case .success(let response):
					do {
						let signUpResponse = try response.map(AuthResponse.self)
						continuation.resume(returning: signUpResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func signIn(request: SignInRequest) async throws -> AuthResponse {
		return try await withCheckedThrowingContinuation { continuation in
			provider.request(.signIn(request: request)) { result in
				switch result {
				case .success(let response):
					do {
						let signInResponse = try response.map(AuthResponse.self)
						continuation.resume(returning: signInResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}

struct SignUpRequest: Encodable {
	let email: String
	let password: String
}

struct SignInRequest: Encodable {
	let email: String
	let password: String
}

struct RefreshRequest: Encodable {
	let refresh: String
}

/// Модель ответа от сервера
struct AuthResponse: Decodable {
	/// ID юзера
	let userID: String
	
	/// Токен доступа
	let accessToken: String

	/// Обновляемый токен
	let refreshToken: String
}
