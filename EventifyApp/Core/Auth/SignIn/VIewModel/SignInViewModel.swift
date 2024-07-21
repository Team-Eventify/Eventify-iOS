//
//  SignInViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var email: String = ""
	@Published var password: String = ""
	@Published var signInStatusMessage: String = ""
	@Published var isLoading: Bool = false
	@AppStorage("isLoading") var isLogin: Bool = false

	/// Приватное свойство для сервиса входа
	private let signInService: SignInServiceProtocol

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter signInService: сервис viewModel'и экрана Вход
	init(signInService: SignInServiceProtocol = SignInService()) {
		self.signInService = signInService
	}

	// MARK: - Public Functions

	/// Отпарвляет запрос на вход
	func signIn() async {
		guard !email.isEmpty, !password.isEmpty else {
			signInStatusMessage = "No email or password found."
			isLogin = false
			print(signInStatusMessage)
			return
		}

		isLoading = true
		let userData: JSON = ["email": email, "password": password]

		do {
			let _ = try await signInService.signIn(json: userData)
			print(signInStatusMessage)
			isLogin = true
		} catch {
			signInStatusMessage = "Error: \(error.localizedDescription)"
			print(signInStatusMessage)
			isLogin = false
		}
		isLoading = false
	}
}
