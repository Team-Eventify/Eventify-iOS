//
//  AuthenticationViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var email: String = ""
	@Published var password: String = ""
	@Published var signUpStatusMessage: String = ""
	@Published var isLoading: Bool = false
	@Published var isError: Bool = true
	@AppStorage("isLoading") var isLogin: Bool = false

	/// Приватное свойство для сервиса регистрации
	private let signUpService: SignUpServiceProtocol

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter signUpService: сервис viewModel'и экрана Регистрации
	init(signUpService: SignUpServiceProtocol = SignUpService()) {
		self.signUpService = signUpService
	}

	// MARK: - Public Functions

	/// Отпарвляет запрос на регистрацию
	func signUp() async {
		guard !email.isEmpty, !password.isEmpty else {
			signUpStatusMessage = "No email or password found."
			print(signUpStatusMessage)
			return
		}

		isLoading = true
		let userData: JSON = ["password": password, "email": email]

		do {
			let _ = try await signUpService.signUp(json: userData)
			signUpStatusMessage = "Success ✅"
			print(signUpStatusMessage)
			isLogin = true
		} catch {
			signUpStatusMessage = "Error: \(error.localizedDescription)"
			print(signUpStatusMessage)
			isLogin = false
			isError = false
		}
		isLoading = false
	}
}
