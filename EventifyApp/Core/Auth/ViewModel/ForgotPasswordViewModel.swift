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
				print("✅ Success")
			} catch {
				print("❌ Error: \(error)")
			}
		}
	}
}
