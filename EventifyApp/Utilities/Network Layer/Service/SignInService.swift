//
//  SignInService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

protocol SignInServiceProtocol {
	func signIn(json: JSON) async throws -> SignInResponse
}

final class SignInService: Request, SignInServiceProtocol {
	func signIn(json: JSON) async throws -> SignInResponse {
		return try await sendRequest(
			endpoint: SignInEndpoint.signIn(json: json),
			responseModel: SignInResponse.self
		)
	}
}

struct SignInResponse: Decodable {
	let token: String
	let refreshToken: String
}
