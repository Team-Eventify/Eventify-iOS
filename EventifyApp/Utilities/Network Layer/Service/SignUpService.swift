//
//  RegistrationRequest.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

protocol SignUpServiceProtocol {
	func signUp(json: JSON) async throws -> SignUpResponse
}

final class SignUpService: Request, SignUpServiceProtocol {
	func signUp(json: JSON) async throws -> SignUpResponse {
		return try await sendRequest(
			endpoint: SignUpEndpoint.signUp(json: json),
			responseModel: SignUpResponse.self
		)
	}
}

struct SignUpResponse: Decodable {
	let message: String
	let user: SignUpUser
}

struct SignUpUser: Decodable {
	let id: Int
	let email: String
}
