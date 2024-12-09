//
//  SignInView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import PopupView
import SwiftUI

/// Вью экрана Входа
struct SignInView: View {
	// MARK: - Private Properties
	@EnvironmentObject private var networkManager: NetworkManager
	@EnvironmentObject private var coordinator: AppCoordinator
	@StateObject private var viewModel: SignInViewModel

	// MARK: - Initialization
	init(viewModel: SignInViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

	// MARK: - Body

	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
		} else {
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
				.edgesIgnoringSafeArea(.bottom)
				.onTapGesture {
					hideKeyboard()
				}
				.popup(
					isPresented: Binding(
						get: { viewModel.loadingState == .failure }, set: { _ in })
				) {
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
	}

	/// Контейнер для содержимого экрана входа
	private var signInContentContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("sign_in_title")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)

			Text("sign_in_description")
				.font(.regularCompact(size: 17))
				.frame(width: 296)

			authTextFields
		}
	}

	/// Поля ввода для авторизации (email и пароль)
	private var authTextFields: some View {
		VStack(alignment: .trailing, spacing: 8) {
			EventifyTextField(
				text: $viewModel.email,
				placeholder: String(
					localized: "email_placeholder", comment: "Email"),
				hasError: false
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
			.keyboardType(.emailAddress)
			.textContentType(.emailAddress)

			EventifySecureField(
				text: $viewModel.password,
				isSecure: true,
				placeholder: String(
					localized: "password_placeholder", comment: "Пароль")
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
			.textContentType(.password)

			forgotPasswordButtonContainerView
		}
		.padding(.top, 40)
	}

	/// Контейнер для кнопок входа и регистрации
	private var signInButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(
				configuration: .signIn,
				isLoading: viewModel.loadingState == .loading,
				isDisabled: viewModel.loadingState == .loading
			) {
				viewModel.signIn(coordinator: coordinator)
			}
			haveAccountContainerView
		}
	}

	/// Кнопка для перехода на экран восстановления пароля
	private var forgotPasswordButtonContainerView: some View {
		VStack(alignment: .trailing, spacing: .zero) {
			Button {
				let viewModel = ForgotPasswordViewModel()
				coordinator.push(.forgotPassword(viewModel))
			} label: {
				Text("forgot_password_button")
			}
		}
	}

	/// Контейнер для кнопки регистрации
	private var haveAccountContainerView: some View {
		HStack(spacing: 12) {
			Text("no_account_question")
				.font(.regularCompact(size: 16))
			Button {
				coordinator.pop()
			} label: {
				Text("registration_title")
					.underline()
					.font(.mediumCompact(size: 16))
					.foregroundStyle(.brandCyan)
			}
		}
		.frame(maxWidth: .infinity)
	}
}
