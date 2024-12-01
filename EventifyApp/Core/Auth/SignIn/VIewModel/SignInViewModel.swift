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
	private let signInService: SignInServiceProtocol
	private let authProvider: AuthenticationProviderProtocol
	
	// MARK: - Initialization
	
	/// Инициализатор
	/// - Parameters:
	///   - signInService: сервис входа
	init(
		signInService: SignInServiceProtocol,
		authProvider: AuthenticationProviderProtocol
	) {
		self.signInService = signInService
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
		let userData: JSON = ["email": email, "password": password]
		
		Task { @MainActor in
			do {
				let response = try await signInService.signIn(json: userData)
				KeychainManager.shared.set(response.userID, key: KeychainKeys.userId)
				KeychainManager.shared.set(response.accessToken, key: KeychainKeys.accessToken)
				KeychainManager.shared.set(response.refreshToken, key: KeychainKeys.refreshToken)
				KeychainManager.shared.set(email, key: KeychainKeys.userEmail)
				KeychainManager.shared.set(password, key: KeychainKeys.userPassword)
				loadingState = .loaded
				authProvider.authenticate()
				coordinator.flow = .main
			} catch {
				loginAttempts += 1
				loadingState = .failure
				try? await Task.sleep(nanoseconds: 2_000_000_000)
				loadingState = .none
			}
		}
	}
}
