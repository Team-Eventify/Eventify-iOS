//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI
import SUINavigation

struct SignUpView: View {
	@StateObject private var viewModel: AuthenticationViewModel

	@State private var isShown: Bool = false

	init(viewModel: AuthenticationViewModel? = nil, isSignIn: Bool) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? AuthenticationViewModel(authenticationService: AuthenticationManager())
		)
	}

    var body: some View {
		ZStack {
			Color.background.ignoresSafeArea()

			VStack(alignment: .leading, spacing: 60) {
				Spacer()
				registrationContentContainerView
				registrationButtonContainerView
				Spacer()
				Spacer()
			}
			.foregroundStyle(Color.secondaryText)
			.frame(maxWidth: .infinity)
			.padding(.horizontal, 16)
		}
		.navigation(isActive: $isShown) {
			TestView()
		}
	}
    
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

	private var authTextFields: some View {
		VStack(spacing: 8) {
			EventifyTextField(text: $viewModel.email, placeholder: "Email", isSucceededValidation: true)
			EventifyTextField(text: $viewModel.password, placeholder: "Пароль", isSucceededValidation: true)
		}
		.padding(.top, 40)
	}

    private var registrationButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(title: "Зарегистрироваться") {
				Task {
					try await viewModel.signIn()
				}
			}

			haveAccountContainerView
		}
	}

    private var haveAccountContainerView: some View {
        HStack(spacing: 12) {
            Text("Уже есть аккаунт?")
                .font(.regularCompact(size: 16))
            Button {
				isShown.toggle()
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
	NavigationViewStorage {
		SignUpView(isSignIn: false)
	}
}
