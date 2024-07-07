//
//  ForgotPasswordViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.06.2024.
//

import Foundation

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
	@Published var email: String = ""
	@Published var isResetSuccessful: Bool = false

	private let authenticationService: AuthenticationService

	init(authenticationService: AuthenticationService) {
		self.authenticationService = authenticationService
	}

	func resetPassword() async throws {
		guard !email.isEmpty else {
			print("🙏 Please enter email!")
			return
		}

		Task {
			do {
				try await authenticationService.resetPassword(email: email)
				isResetSuccessful = true
				print("✅ Success")
			} catch {
				isResetSuccessful = false
				print("❌ Error: \(error)")
			}
		}
	}
}
