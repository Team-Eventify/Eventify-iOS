//
//  TokenService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.09.2024.
//

import Foundation

protocol TokenServiceProtocol {
    func refreshTokens() async throws -> TokenResponse
}

final class TokenService: Request, TokenServiceProtocol {
    /// Синглтон
	static let shared = TokenService()
    
    func refreshTokens() async throws -> TokenResponse {
        let refreshToken =
            KeychainManager.shared.get(key: KeychainKeys.refreshToken) ?? ""
		return try await sendRequest(
            endpoint: TokenEndpoint.refresh(
                refreshToken: refreshToken
            ),
            responseModel: TokenResponse.self
        )
    }
}

/// Response модель токена
struct TokenResponse: Decodable {
    let userID: String
    let accessToken: String
    let refreshToken: String
}
