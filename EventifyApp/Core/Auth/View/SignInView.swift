//
//  SignInView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI
import SUINavigation

struct SignInView: View {
	@StateObject private var viewModel: SignInViewModel

	@Environment(\.dismiss)
	var dismiss

	@State private var isLogined: Bool = false
	@State private var isForgotPassword: Bool = false

	init(viewModel: SignInViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? SignInViewModel(authenticationService: AuthenticationManager())
		)
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 60) {
			Spacer()
			signInContentContainerView
			signInButtonContainerView
			Spacer()
			Spacer()
		}
		.foregroundStyle(Color.secondaryText)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(.horizontal, 16)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.navigationBarBackButtonHidden(true)
		.navigation(isActive: $isLogined) {
			TabBarView()
		}
		.navigation(isActive: $isForgotPassword) {
			ForgotPasswordView()
		}
	}

	private var signInContentContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Вход")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)

			Text("Пожалуйста,  войдите в свой аккаунт. Это займёт меньше минуты.")
				.font(.regularCompact(size: 17))
				.frame(width: 296)

			authTextFields
		}
	}

	private var authTextFields: some View {
		VStack(alignment: .trailing, spacing: 8) {
			EventifyTextField(text: $viewModel.email, placeholder: "Email", isSucceededValidation: true, isSecure: false)
			EventifyTextField(text: $viewModel.password, placeholder: "Пароль", isSucceededValidation: true, isSecure: true)

			forgotPasswordButtonContainerView
		}
		.padding(.top, 40)
	}

	private var signInButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(title: "Войти") {
				Task {
					do {
						try await viewModel.signIn()
						isLogined.toggle()
					} catch {
						print(error.localizedDescription)
					}
				}
			}

			haveAccountContainerView
		}
	}

	private var forgotPasswordButtonContainerView: some View {
		VStack(alignment: .trailing, spacing: .zero) {
			Button {
				isForgotPassword.toggle()
			} label: {
				Text("Забыли пароль?")
			}
		}
	}

	private var haveAccountContainerView: some View {
		HStack(spacing: 12) {
			Text("Нет аккаунта?")
				.font(.regularCompact(size: 16))
			Button {
				dismiss()
			} label: {
				Text("Регистрация")
					.underline()
					.font(.mediumCompact(size: 16))
					.foregroundStyle(Color.brandYellow)
			}
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	NavigationViewStorage {
		SignInView()
	}
}
