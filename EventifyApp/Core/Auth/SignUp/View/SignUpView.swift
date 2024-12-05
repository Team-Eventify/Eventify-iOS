//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI
import PopupView

struct SignUpView: View {
	@StateObject private var viewModel: SignUpViewModel
	@EnvironmentObject private var networkManager: NetworkConnection
	@EnvironmentObject private var coordinator: AppCoordinator
	
	init(viewModel: SignUpViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	var body: some View {
		if networkManager.isDisconnected {
			NoInternetView()
		} else {
			VStack(alignment: .leading, spacing: 60) {
				Spacer()
				registrationContentContainerView
				registrationButtonContainerView
				Spacer()
				Spacer()
			}
			.foregroundStyle(Color.secondaryText)
			.navigationBarBackButtonHidden(true)
			.padding(.horizontal, 16)
			.background(.bg, ignoresSafeAreaEdges: .all)
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
					.type(.floater(verticalPadding: 10, useSafeAreaInset: true))
					.disappearTo(.bottomSlide)
					.position(.bottom)
					.closeOnTap(true)
					.autohideIn(3)
			}
		}
	}
	
	private var registrationContentContainerView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("registration_title")
				.font(.semiboldCompact(size: 40))
				.foregroundStyle(Color.mainText)
			
			Text("registration_description")
				.font(.regularCompact(size: 17))
				.frame(width: 296)
			authTextFields
			requirementsContainerView
		}
	}
	
	private var authTextFields: some View {
		VStack(spacing: 8) {
			EventifyTextField(
				text: $viewModel.email,
				placeholder: String(localized: "email_placeholder"),
				hasError: false
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
			.keyboardType(.emailAddress)
			.textContentType(.emailAddress)
			.overlay(
				HStack {
					Spacer()
					Image(
						systemName: viewModel.isEmailValid
						? "checkmark.circle.fill" : "xmark.circle.fill"
					)
					.foregroundColor(
						viewModel.isEmailValid ? .brandCyan : .error
					)
					.opacity(viewModel.email.isEmpty ? 0 : 1)
				}
					.padding(.trailing, 20)
			)
			
			EventifySecureField(
				text: $viewModel.password,
				isSecure: true,
				placeholder: String(localized: "password_placeholder")
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
			.textContentType(.newPassword)
			
			EventifySecureField(
				text: $viewModel.confirmPassword,
				isSecure: true,
				placeholder: String(localized: "confirm_password_placeholder")
			)
			.changeEffect(.shake(rate: .fast), value: viewModel.loginAttempts)
			.textContentType(.newPassword)
		}
		.padding(.top, 40)
	}
	
	private var requirementsContainerView: some View {
		VStack(alignment: .leading, spacing: 4) {
			ForEach(viewModel.validationRules.indices, id: \.self) { index in
				ValidationRow(rule: viewModel.validationRules[index])
			}
		}
	}
	
	private var registrationButtonContainerView: some View {
		VStack(spacing: 20) {
			EventifyButton(
				configuration: .signUp,
				isLoading: viewModel.loadingState == .loading,
				isDisabled: viewModel.isButtonDisabled
			) {
				viewModel.signUp(coordinator: coordinator)
			}
			haveAccountContainerView
		}
	}
	
	private var haveAccountContainerView: some View {
		HStack(spacing: 12) {
			Text("have_account_question")
				.font(.regularCompact(size: 16))
			Button {
				let authService = AuthService()
				let authProvider = AuthenticationProvider()
				let viewModel = SignInViewModel(authService: authService, authProvider: authProvider)
				coordinator.push(.login(viewModel))
			} label: {
				Text("login_title")
					.underline()
					.font(.mediumCompact(size: 16))
					.foregroundStyle(.brandCyan)
			}
		}
		.frame(maxWidth: .infinity)
	}
}
