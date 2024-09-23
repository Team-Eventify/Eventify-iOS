//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import PopupView
import Pow
import SUINavigation
import SwiftUI

/// Вью экрана регистрации
struct SignUpView: View {
    // MARK: - Private Properties

    /// ViewModel для управления логикой вью
    @StateObject private var viewModel: SignUpViewModel

    /// Состояние для навигации к экрану Входа
    @State private var navigateToLoginView: Bool = false

    // MARK: - Initialization

    /// Инициализация
    /// - Parameters:
    ///   - signUpService: сервис регистрации
    init(signUpService: SignUpServiceProtocol) {
        _viewModel = StateObject(wrappedValue: SignUpViewModel(signUpService: signUpService))
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

        .onTapGesture {
            hideKeyboard()
        }

        /// Навигация к экрану входа
        .navigation(isActive: $navigateToLoginView) {
            SignInView(signInService: SignInService())
        }

        /// Навигация к основному экрану после успешной регистрации
        .navigation(
            isActive: Binding(
                get: { viewModel.loadingState == .loaded },
                set: { _ in }
            )
        ) {
            PersonalCategoriesView()
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

    // MARK: - UI Components

    /// Контейнер с содержимым регистрации
    private var registrationContentContainerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Регистрация")
                .font(.semiboldCompact(size: 40))
                .foregroundStyle(Color.mainText)

            Text(
                "Пожалуйста, создайте новый аккаунт. Это займёт меньше минуты."
            )
            .font(.regularCompact(size: 17))
            .frame(width: 296)
            authTextFields
        }
    }

    /// Текстовые поля для ввода данных регистрации
    private var authTextFields: some View {
        VStack(spacing: 8) {
            EventifyTextField(
                text: $viewModel.email, placeholder: "Email", isSecure: false
            )
            .changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            
            EventifyTextField(
                text: $viewModel.password, placeholder: "Пароль", isSecure: true
            )
            .changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
            .textContentType(.newPassword)
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
                    .foregroundStyle(.brandCyan)
            }
            .animation(.default, value: navigateToLoginView)
            .changeEffect(
                .shine.delay(0.5),
                value: navigateToLoginView,
                isEnabled: navigateToLoginView
            )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SignUpView(signUpService: SignUpService())
}
