//
//  AuthenticationViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
	@Published var email: String = ""
	@Published var password: String = ""

	private let authenticationService: AuthenticationService

	init(authenticationService: AuthenticationService) {
		self.authenticationService = authenticationService
	}

	func signUp() async throws {
		guard !email.isEmpty, !password.isEmpty else {
			print("No email or password found.")
			return
		}

		Task {
			do {
				let returnedUserData = try await authenticationService.createUser(email: email, password: password)
				print("✅ Success")
				print(returnedUserData)
			} catch {
				print("❌ Error: \(error)")
			}
		}
	}
}
