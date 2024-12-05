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
	@Published var loginAttempts = 0
	
	// MARK: - Private Properties
	
	/// Приватное свойство для сервиса входа
	private let authService: AuthServiceProtocol
	private let authProvider: AuthenticationProviderProtocol
	
	// MARK: - Initialization
	
	/// Инициализатор
	/// - Parameters:
	///   - signInService: сервис входа
	init(
		authService: AuthServiceProtocol,
		authProvider: AuthenticationProviderProtocol
	) {
		self.authService = authService
		self.authProvider = authProvider
	}
	
	// MARK: - Public Functions

	/// Отправляет запрос на вход
	func signIn(coordinator: AppCoordinator) {
		guard !email.isEmpty, !password.isEmpty else {
			loginAttempts += 1
			return
		}
		
		loadingState = .loading
		let signInRequest: SignInRequest = .init(email: email, password: password)
		
		Task { @MainActor in
			do {
				let response = try await authService.signIn(request: signInRequest)
				saveUserData(response: response)
				loadingState = .loaded
				authProvider.authenticate()
				coordinator.flow = .main
			} catch {
				handleSignInError(error)
			}
		}
	}
	
	private func saveUserData(response: AuthResponse   ) {
		KeychainManager.shared.set(response.userID, key: KeychainKeys.userId)
		KeychainManager.shared.set(response.accessToken, key: KeychainKeys.accessToken)
		KeychainManager.shared.set(response.refreshToken, key: KeychainKeys.refreshToken)
		KeychainManager.shared.set(email, key: KeychainKeys.userEmail)
		KeychainManager.shared.set(password, key: KeychainKeys.userPassword)
	}
	
	private func handleSignInError(_ error: Error) {
		loginAttempts += 1
		loadingState = .failure
		Task { @MainActor in
			try? await Task.sleep(nanoseconds: 2_000_000_000)
			loadingState = .none
		}
	}
}
