//
//  SignInViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var email: String = ""
	@Published var password: String = ""
	@Published var loadingState: LoadingState = .none
	@Published var showForgotPassScreen: Bool = false

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
	func signIn() {
		guard !email.isEmpty, !password.isEmpty else {
			Constants.isLogin = false
			return
		}

		loadingState = .loading
		let userData: JSON = ["email": email, "password": password]

		Task { @MainActor in
			do {
				let _ = try await signInService.signIn(json: userData)
				Constants.isLogin = true
				loadingState = .loaded
			} catch {
				loadingState = .failure
				Constants.isLogin = false
				try? await Task.sleep(nanoseconds: 2_000_000_000)
				loadingState = .none
			}
		}
	}
}
