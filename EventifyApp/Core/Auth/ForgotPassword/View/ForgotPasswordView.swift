//
//  ForgotPasswordView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 16.06.2024.
//

import SUINavigation
import SwiftUI

/// Вью экрана Сброса Пароля
struct ForgotPasswordView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel: ForgotPasswordViewModel

    @Environment(\.dismiss)
    var dismiss

    // MARK: - Initialization

    /// Инициализатор
    /// - Parameter viewModel: модель экрана сброса пароля
    init(viewModel: ForgotPasswordViewModel? = nil) {
        _viewModel = StateObject(
            wrappedValue: viewModel ?? ForgotPasswordViewModel()
        )
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            forgotPasswordContainerView
            restoreButtonContainerView
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(.bg, ignoresSafeAreaEdges: .all)
    }

    /// Контейнер для содержимого экрана сброса пароля
    private var forgotPasswordContainerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Сброс пароля")
                .font(.semiboldCompact(size: 40))
                .foregroundStyle(Color.mainText)

            Text(
                "Укажите email, который вы использовали для создания аккаунта.Мы отправим письмо с ссылкой для сброса пароля."
            )
            .font(.regularCompact(size: 17))
            .foregroundStyle(Color.secondaryText)
            .frame(width: 400)
        }
    }

    /// Контейнер для поля ввода email и кнопки отправки
    private var restoreButtonContainerView: some View {
        VStack(spacing: 40) {
            EventifyTextField(text: $viewModel.email, placeholder: "Email", hasError: false)
            .changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)

            EventifyButton(
                configuration: .forgotPassword, isLoading: false, isDisabled: false
            ) {
                Task {
                    do {
                        try await viewModel.resetPassword()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationViewStorage {
        ForgotPasswordView()
    }
}
