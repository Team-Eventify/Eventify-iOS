//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI
import SUINavigation

struct SignUpView: View {
	@StateObject private var viewModel: SignUpViewModel

	@State private var isRegistered: Bool = false
	@State private var isLogin: Bool = false

	init(viewModel: SignUpViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? SignUpViewModel(authenticationService: AuthenticationManager())
		)
	}

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
		.background(Color.background,ignoresSafeAreaEdges: .all)
		.navigation(isActive: $isRegistered) {
			MainView()
		}
		.navigation(isActive: $isLogin) {
			SignInView()
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
					try await viewModel.signUp()
				}
				isRegistered.toggle()
			}

			haveAccountContainerView
		}
	}

    private var haveAccountContainerView: some View {
        HStack(spacing: 12) {
            Text("Уже есть аккаунт?")
                .font(.regularCompact(size: 16))
            Button {
				isLogin.toggle()
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
		SignUpView()
	}
}
