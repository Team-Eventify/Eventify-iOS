//
//  ForgotPasswordViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 18.06.2024.
//

import Foundation

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var email: String = ""
	@Published var loadingState: LoadingState = .failure

	// MARK: - Public Functions

	func resetPassword() async throws {
		guard !email.isEmpty else {
			print("🙏 Please enter email!")
			return
		}
	}
}
