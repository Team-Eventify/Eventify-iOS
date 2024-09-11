//
//  SignInView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SUINavigation
import SwiftUI

/// Вью экрана Входа
struct SignInView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel: SignInViewModel

	@Environment(\.dismiss)
	var dismiss

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter viewModel: модель экрана Вход
	init(viewModel: SignInViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? SignInViewModel()
		)
	}

	// MARK: - Body

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
		.navigation(isActive: $viewModel.showForgotPassScreen) {
			ForgotPasswordView()
		}
		
		.popup(isPresented: Binding(get: { viewModel.loadingState == .failure }, set: { _ in })) {
			EventifySnackBar(config: .failure)
				} customize: {
					$0
						.type(
							.floater(
								verticalPadding: 10,
								useSafeAreaInset: true
							)
						)
						.disappearTo(.bottomSlide)
						.position(.bottom)
						.closeOnTap(true)
						.autohideIn(3)
		}
	}

	/// Контейнер для содержимого экрана входа
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

	/// Поля ввода для авторизации (email и пароль)
	private var authTextFields: some View {
		VStack(alignment: .trailing, spacing: 8) {
			EventifyTextField(text: $viewModel.email, placeholder: "Email", isSecure: false)
			EventifyTextField(text: $viewModel.password, placeholder: "Пароль", isSecure: true)

			forgotPasswordButtonContainerView
		}
		.padding(.top, 40)
	}

	/// Контейнер для кнопок входа и регистрации
	private var signInButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(title: "Войти", isLoading: viewModel.loadingState == .loaded, isDisabled: false) {
				viewModel.signIn()
			}
			haveAccountContainerView
		}
	}

	/// Кнопка для перехода на экран восстановления пароля
	private var forgotPasswordButtonContainerView: some View {
		VStack(alignment: .trailing, spacing: .zero) {
			Button {
				Constants.isLogin = true
			} label: {
				Text("Забыли пароль?")
			}
		}
	}

	/// Контейнер для кнопки регистрации
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
