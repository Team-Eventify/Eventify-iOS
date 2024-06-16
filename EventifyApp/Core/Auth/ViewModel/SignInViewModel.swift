//
//  SignInViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import Foundation

final class SignInViewModel: ObservableObject {
	@Published var email: String = ""
	@Published var password: String = ""

	private let authenticationService: AuthenticationService

	init(authenticationService: AuthenticationService) {
		self.authenticationService = authenticationService
	}

	func signIn() async throws {
		guard !email.isEmpty, !password.isEmpty else {
			print("No email or password found.")
			return
		}

		Task {
			do {
				let returnedUserData = try await authenticationService.loginUser(email: email, password: password)
				print("✅ Success")
				print(returnedUserData)
			} catch {
				print("❌ Error: \(error)")
			}
		}
	}
}
