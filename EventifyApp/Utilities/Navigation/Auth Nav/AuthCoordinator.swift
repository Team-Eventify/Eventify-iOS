//
//  AuthCoordinator.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.11.2024.
//

import SwiftUI

class AuthCoordinator: ObservableObject {
	private let authProvider: AuthenticationProviderProtocol

	init(authProvider: AuthenticationProviderProtocol) {
		self.authProvider = authProvider
	}

	func build() -> some View {
		let signUpService = SignUpService()
		let viewModel = SignUpViewModel(signUpService: signUpService, authProvider: authProvider)
		let view = SignUpView(viewModel: viewModel, coordinator: self)
		return view
	}

	@ViewBuilder
	func destination(for screen: AuthScreens) -> some View {
		switch screen {
		case .signIn:
			buildSignIn()
		case .forgotPassword:
			buildForgotPassword()
		case .setCategories:
			buildSetCategories()
		}
	}

	private func buildSignIn() -> some View {
		let signInService = SignInService()
		let viewModel = SignInViewModel(signInService: signInService, authProvider: authProvider)
		let view = SignInView(viewModel: viewModel)
		return view
	}

	private func buildForgotPassword() -> some View {
		let viewModel = ForgotPasswordViewModel()
		let view = ForgotPasswordView(viewModel: viewModel)
		return view
	}

	private func buildSetCategories() -> some View {
		let categoriesService = CategoriesService()
		let viewModel = PersonalCategoriesViewModel(categoriesService: categoriesService)
		let view = PersonalCategoriesView(viewModel: viewModel)
		return view
	}

	enum AuthScreens: Hashable {
		case signIn
		case forgotPassword
		case setCategories
	}
}
