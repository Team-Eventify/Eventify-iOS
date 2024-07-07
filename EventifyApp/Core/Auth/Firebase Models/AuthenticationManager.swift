//
//  AuthenticationManager.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import Foundation
import FirebaseAuth

protocol AuthenticationService {
	func getAuthenticatedUser() throws -> AuthDataResultModel
	func createUser(email: String, password: String) async throws -> AuthDataResultModel
	func loginUser(email: String, password: String) async throws -> AuthDataResultModel
	func resetPassword(email: String) async throws
	func signOut() throws
}

final class AuthenticationManager: AuthenticationService {

	func getAuthenticatedUser() throws -> AuthDataResultModel {
		guard let user = Auth.auth().currentUser else {
			throw URLError(.badServerResponse)
		}
		return AuthDataResultModel(user: user)
	}

	@discardableResult
	func createUser(email: String, password: String) async throws -> AuthDataResultModel {
		let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
		return AuthDataResultModel(user: authDataResult.user)
	}

	@discardableResult
	func loginUser(email: String, password: String) async throws -> AuthDataResultModel {
		let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
		return AuthDataResultModel(user: authDataResult.user)
	}

	func resetPassword(email: String) async throws {
		try await Auth.auth().sendPasswordReset(withEmail: email)
	}

	func signOut() throws {
		try Auth.auth().signOut()
	}
}
