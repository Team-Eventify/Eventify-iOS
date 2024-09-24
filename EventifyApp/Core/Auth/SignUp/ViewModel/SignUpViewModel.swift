//
//  AuthenticationViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

/// Вью модель экрана Регистрации пользователя
final class SignUpViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loadingState: LoadingState = .none
    @Published var loginAttempts = 0
    @Published var navigateToLoginView: Bool = false

    // MARK: - Private Properties

    /// Приватное свойство для сервиса регистрации
    private let signUpService: SignUpServiceProtocol

    // MARK: - Initialization

    /// Инициализатор
    /// - Parameters:
    ///   - signUpService: сервис регистрации
    init(signUpService: SignUpServiceProtocol) {
        self.signUpService = signUpService
    }

    // MARK: - Public Functions

    /// Отправляет запрос на регистрацию
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            loginAttempts += 1
            return
        }

        loadingState = .loading
        let userData: JSON = ["password": password, "email": email]

        Task { @MainActor in
            do {
                let response = try await signUpService.signUp(json: userData)
                KeychainManager.shared.set(response.userID, key: KeychainKeys.userId)
                KeychainManager.shared.set(response.accessToken, key: KeychainKeys.accessToken)
                KeychainManager.shared.set(response.refreshToken, key: KeychainKeys.refreshToken)
                KeychainManager.shared.set(email, key: KeychainKeys.userEmail)
                KeychainManager.shared.set(password, key: KeychainKeys.userPassword)
                loadingState = .loaded
            } catch {
                loginAttempts += 1
                loadingState = .failure
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                loadingState = .none
            }
        }
    }
}
