//
//  ForgotPasswordView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 16.06.2024.
//

import SwiftUI
import SUINavigation

struct ForgotPasswordView: View {
	@StateObject private var viewModel: ForgotPasswordViewModel

	@Environment(\.dismiss)
	var dismiss

	init(viewModel: ForgotPasswordViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? ForgotPasswordViewModel(authenticationService: AuthenticationManager())
		)
	}

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
			.navigationBarBackButtonHidden(true)
	}

	private var forgotPasswordContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Сброс пароля")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)

			Text("Укажите email, который вы использовали для создания аккаунта.Мы отправим письмо с ссылкой для сброса пароля.")
				.font(.regularCompact(size: 17))
				.foregroundStyle(Color.secondaryText)
				.frame(width: 400)
		}
	}

	private var restoreButtonContainerView: some View {
		VStack(spacing: 40) {
			EventifyTextField(text: $viewModel.email, placeholder: "Email", isSucceededValidation: true)

			EventifyButton(title: "Отправить") {

				Task {
					do {
						try await viewModel.resetPassword()
						dismiss()
					} catch {
						print(error)
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