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

    // MARK: - Private Properties

    /// Приватное свойство для сервиса входа
    private let signInService: SignInServiceProtocol

    // MARK: - Initialization

    /// Инициализатор
    /// - Parameters:
    ///   - signInService: сервис входа
    init(signInService: SignInServiceProtocol) {
        self.signInService = signInService
    }

    // MARK: - Public Functions

    /// Отправляет запрос на вход
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
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
                Constants.isLogin = true
                print(response)
            } catch {
                loadingState = .failure
                Constants.isLogin = false
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                loadingState = .none
            }
        }
    }
}
