//
//  AuthPlugin.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//

import Foundation
import Moya

enum TokenError: Error {
	case refreshTokenNotFound
}

protocol TokenServiceProtocol {
	func refreshTokens() async throws -> TokenResponse
}

final class TokenService: TokenServiceProtocol {
	private let provider = MoyaProvider<API.AuthEndpoints>(plugins: [NetworkLoggerPlugin(), AccessTokenPlugin(tokenClosure: { _ in
		let token = KeychainManager.shared.get(key: KeychainKeys.accessToken) ?? ""
		Logger.log(level: .info, "AccessTokenPlugin: Using token: \(token)")
		return token
	})])
	
	func refreshTokens() async throws -> TokenResponse {
        guard let refreshToken = await KeychainManager.shared.get(key: KeychainKeys.refreshToken) else {
			throw TokenError.refreshTokenNotFound
		}
		
		let refreshRequest = RefreshRequest(refresh: refreshToken)
		
		return try await withCheckedThrowingContinuation { continuation in
			provider.request(.refresh(request: refreshRequest)) { result in
				switch result {
				case .success(let response):
					do {
						let tokenResponse = try response.map(TokenResponse.self)
						continuation.resume(returning: tokenResponse)
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

struct TokenResponse: Decodable {
	let userID: String
	let accessToken: String
	let refreshToken: String
}
