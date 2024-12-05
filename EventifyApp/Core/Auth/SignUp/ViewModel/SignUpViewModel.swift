//
//  AuthenticationViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import Combine
import SwiftUI

final class SignUpViewModel: ObservableObject {
	@Published var email: String = ""
	@Published var password: String = ""
	@Published var confirmPassword: String = ""
	@Published var loadingState: LoadingState = .none
	@Published var loginAttempts = 0
	@Published var validationRules: [ValidationRule] = []
	@Published var showAlert = false
	@Published var isEmailValid: Bool = false

	private var isLogin: Bool = false

	var isButtonDisabled: Bool {
		!isEmailValid || validationRules.contains(where: { !$0.isValid })
		|| password != confirmPassword || email.isEmpty
	}
	
	private let authService: AuthServiceProtocol
	private var cancellables = Set<AnyCancellable>()
	private let authProvider: AuthenticationProviderProtocol
	
	private let rulesDescriptions:
	[(description: String, validator: (String) -> Bool, icon: Image)] = [
		(
			String(localized: "password_min_length"),
			{ $0.count >= 6 },
			Image(systemName: "checkmark")
		),
		(
			String(localized: "password_uppercase"),
			{ $0.rangeOfCharacter(from: .uppercaseLetters) != nil },
			Image(systemName: "checkmark")
		),
		(
			String(localized: "password_number"),
			{ $0.rangeOfCharacter(from: .decimalDigits) != nil },
			Image(systemName: "checkmark")
		),
		(
			String(localized: "password_no_whitespace"),
			{ $0.rangeOfCharacter(from: .whitespaces) == nil },
			Image(systemName: "checkmark")
		),
		(
			String(localized: "password_latin_only"),
			{
				$0.rangeOfCharacter(
					from: CharacterSet(
						charactersIn:
							"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					)) != nil
				&& $0.rangeOfCharacter(
					from: CharacterSet(
						charactersIn:
							"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
					).inverted) == nil
			},
			Image(systemName: "checkmark")
		),
	]
	
	init(authService: AuthServiceProtocol, authProvider: AuthenticationProviderProtocol) {
		self.authService = authService
		self.authProvider = authProvider
		setupBindings()
	}

	func signUp(coordinator: AppCoordinator) {
		guard !email.isEmpty, !password.isEmpty, password == confirmPassword
		else {
			loginAttempts += 1
			return
		}

		loadingState = .loading
		
		let signUpRequest = SignUpRequest(email: email, password: password)
		
		Task { @MainActor in
			do {
				let response = try await authService.signUp(request: signUpRequest)
				saveUserData(response: response)
				loadingState = .loaded
				isLogin = true
				navigateToCategoriesView(coordinator: coordinator)
			} catch {
				handleSignUpError(error)
			}
		}
	}
	
	private func setupBindings() {
		$password
			.receive(on: RunLoop.main)
			.map { [weak self] password -> [ValidationRule] in
				guard let self = self else { return [] }
				return self.validate(password: password)
			}
			.assign(to: &$validationRules)
		
		$email
			.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
			.map { [weak self] email -> Bool in
				guard let self = self else { return false }
				return isValidEmail(email)
			}
			.assign(to: &$isEmailValid)
	}
	
	private func validate(password: String) -> [ValidationRule] {
		rulesDescriptions.map {
			ValidationRule(
				description: $0.description,
				isValid: $0.validator(password),
				correctIcon: $0.icon
			)
		}
	}
	
	private func isValidEmail(_ email: String) -> Bool {
		guard
			let detector = try? NSDataDetector(
				types: NSTextCheckingResult.CheckingType.link.rawValue)
		else {
			return false
		}
		let range = NSRange(location: 0, length: email.utf16.count)
		let matches = detector.matches(in: email, options: [], range: range)
		
		guard let match = matches.first, matches.count == 1 else {
			return false
		}
		
		return match.range == range && match.url?.scheme == "mailto"
	}
	
	private func saveUserData(response: AuthResponse) {
		KeychainManager.shared.set(response.userID, key: KeychainKeys.userId)
		KeychainManager.shared.set(response.accessToken, key: KeychainKeys.accessToken)
		KeychainManager.shared.set(response.refreshToken, key: KeychainKeys.refreshToken)
		KeychainManager.shared.set(email, key: KeychainKeys.userEmail)
		KeychainManager.shared.set(password, key: KeychainKeys.userPassword)
	}

	private func navigateToCategoriesView(coordinator: AppCoordinator) {
		let categoryService = CategoryService()
		let authProvider = AuthenticationProvider()
		let viewModel = CategoriesViewModel(categoriesService: categoryService)
		viewModel.initAuthProvider(authProvider: authProvider)
		coordinator.push(.setCategories(viewModel))
	}

	private func handleSignUpError(_ error: Error) {
		loginAttempts += 1
		loadingState = .failure
		Task { @MainActor in
			try? await Task.sleep(nanoseconds: 2_000_000_000)
			loadingState = .none
		}
	}
}
