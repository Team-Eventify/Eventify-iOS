//
//  ForgotPasswordView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 16.06.2024.
//

import SwiftUI
import SUINavigation

struct ForgotPasswordView: View {
	@State private var email: String = ""
	@State private var isSended: Bool = false

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
			.background(Color.background, ignoresSafeAreaEdges: .all)
			.navigationBarBackButtonHidden(true)
			.navigation(isActive: $isSended) {
				SignInView()
			}
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
			EventifyTextField(text: $email, placeholder: "Email", isSucceededValidation: true)

			EventifyButton(title: "Отправить") {
				isSended.toggle()
				print("Отправил!")
			}
		}
	}
}

#Preview {
	NavigationViewStorage {
		ForgotPasswordView()
	}
}
