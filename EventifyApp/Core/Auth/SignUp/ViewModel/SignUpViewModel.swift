//
//  AuthenticationViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

/// TODO: ДОКА
final class SignUpViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var email: String = ""
	@Published var password: String = ""
	@Published var loadingState: LoadingState = .none

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
	func signUp() {
		guard !email.isEmpty, !password.isEmpty else {
			return
		}

		loadingState = .loading
		let userData: JSON = ["password": password, "email": email]

		Task { @MainActor in
			do {
				let _ = try await signUpService.signUp(json: userData)
				loadingState = .loaded
			} catch {
				loadingState = .failure
				try? await Task.sleep(nanoseconds: 2_000_000_000)
				loadingState = .none
			}
		}
	}
}
