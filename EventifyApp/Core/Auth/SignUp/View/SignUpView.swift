//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI
import SUINavigation
import PopupView

/// Вью экрана регистрации
struct SignUpView: View {
	// MARK: - Private Properties

	/// ViewModel для управления логикой вью
	@StateObject private var viewModel: SignUpViewModel

	/// Состояние для навигации к экрану Входа
	@State private var navigateToLoginView: Bool = false

	// MARK: - Initialization

	/// Инициализация
	/// - Parameter viewModel: вью модель экрана регистрации
	init(viewModel: SignUpViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? SignUpViewModel()
		)
	}

	// MARK: - Body

	var body: some View {
		VStack(alignment: .leading, spacing: 60) {
			Spacer()
			registrationContentContainerView
			registrationButtonContainerView
			Spacer()
			Spacer()
		}
		.foregroundStyle(Color.secondaryText)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(.horizontal, 16)
		.navigationBarBackButtonHidden(true)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.edgesIgnoringSafeArea(.bottom)

		/// Навигация к экрану входа
		.navigation(isActive: $navigateToLoginView) {
			SignInView()
		}

		/// Навигация к основному экрану после успешной регистрации
		.navigation(isActive: Binding(
			get: { viewModel.loadingState == .loaded },
			set: { _ in }
		)) {
			PersonalCategoriesView()
		}

		// TODO: - Передавать текст ошибки в popup
		.popup(isPresented: Binding(get: { viewModel.loadingState == .failure }, set: { _ in })) {
					AuthSnackBar()
				} customize: {
					$0
						.type(.floater())
						.disappearTo(.bottomSlide)
						.position(.bottom)
						.useKeyboardSafeArea(true)
						.closeOnTap(true)
						.autohideIn(2)
				}
	}

	// MARK: - UI Components

	/// Контейнер с содержимым регистрации
	private var registrationContentContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Регистрация")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)

			Text("Пожалуйста, создайте новый аккаунт. Это займёт меньше минуты.")
				.font(.regularCompact(size: 17))
				.frame(width: 296)
			authTextFields
		}
	}

	/// Текстовые поля для ввода данных регистрации
	private var authTextFields: some View {
		VStack(spacing: 8) {
			EventifyTextField(text: $viewModel.email, placeholder: "Email", isSecure: false)
			EventifyTextField(text: $viewModel.password, placeholder: "Пароль", isSecure: true)
		}
		.padding(.top, 40)
	}

	/// Контейнер с кнопкой регистрации
	private var registrationButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(
				title: "Зарегистрироваться",
				isLoading: viewModel.loadingState == .loading,
				isDisabled: viewModel.loadingState == .loading
			) {
				viewModel.signUp()
			}
			haveAccountContainerView
		}
	}

	/// Контейнер с кнопкой для перехода на экран Входа
	private var haveAccountContainerView: some View {
		HStack(spacing: 12) {
			Text("Уже есть аккаунт?")
				.font(.regularCompact(size: 16))
			Button {
				navigateToLoginView.toggle()
			} label: {
				Text("Войти")
					.underline()
					.font(.mediumCompact(size: 16))
					.foregroundStyle(Color.brandYellow)
			}
		}
		.frame(maxWidth: .infinity)
	}
}



#Preview {
	SignUpView()
}
