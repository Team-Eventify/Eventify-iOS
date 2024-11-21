//
//  ForgotPasswordView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 16.06.2024.
//

import PopupView
import SwiftUI

/// Вью экрана Сброса Пароля
struct ForgotPasswordView: View {
	// MARK: - Private Properties
	@EnvironmentObject private var networkManager: NetworkManager

	@StateObject private var viewModel: ForgotPasswordViewModel

	@Environment(\.dismiss)
	var dismiss

	// MARK: - Initialization

	init() {
		_viewModel = .init(wrappedValue: ForgotPasswordViewModel())
	}

	// MARK: - Body

	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
        } else {
            VStack(spacing: 40) {
                Spacer()
                forgotPasswordContainerView
                restoreButtonContainerView
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(.bg, ignoresSafeAreaEdges: .all)
        }
	}

	/// Контейнер для содержимого экрана сброса пароля
	private var forgotPasswordContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("forgot_password_title")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)

			Text("forgot_password_description")
				.font(.regularCompact(size: 17))
				.foregroundStyle(Color.secondaryText)
		}
	}

	/// Контейнер для поля ввода email и кнопки отправки
	private var restoreButtonContainerView: some View {
		VStack(spacing: 40) {
			EventifyTextField(
				text: $viewModel.email,
				placeholder: String(localized: "email_placeholder"),
				hasError: false
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)

			EventifyButton(
				configuration: .forgotPassword, isLoading: false,
				isDisabled: false
			) {
				Task {
					do {
						try await viewModel.resetPassword()
					} catch {
						Logger.log(level: .error(error), "")
					}
				}
			}
		}
	}
}

#Preview {
	ForgotPasswordView()
		.environmentObject(NetworkManager())
}
