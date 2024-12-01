//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import Flow
import PopupView
import Pow
import SwiftUI

/// Вью детального экрана профиля
struct ProfileDetailView: View {
	// MARK: - Private Properties
	@StateObject private var viewModel = ProfileDetailViewModel(userService: UserService())
	@StateObject private var categoriesModel = CategoriesViewModel(categoriesService: CategoriesService())
	
	@EnvironmentObject private var coordinator: AppCoordinator
	@EnvironmentObject private var networkManager: NetworkManager

	@State private var animation: Bool = true


	// MARK: - Initialization
//	init() {
//		_viewModel = StateObject(
//			wrappedValue: ProfileDetailViewModel(userService: UserService())
//		)
//		_categoriesModel = StateObject(
//			wrappedValue: CategoriesViewModel(categoriesService: CategoriesService())
//		)
//	}

	// MARK: - Body

	var body: some View {
		if networkManager.isDisconnected {
			NoInternetView()
		} else {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 20) {
					nameField
					surnameField
					lastNameField
					emailField
					telegramField
					categoriesSection
					saveButton
					Spacer()
					Spacer()
				}
				.padding(.horizontal, 16)
				.onAppear {
					viewModel.getUser()
					categoriesModel.getCategories()
					categoriesModel.getUserCategories()
				}
			}
			.background(.bg, ignoresSafeAreaEdges: .all)
		}
	}

	private var nameField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("label_first_name")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			EventifyTextField(
				text: $viewModel.name,
				placeholder: String(localized: "placeholder_enter_first_name"),
				hasError: false)
		}
	}

	private var surnameField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("label_last_name")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			EventifyTextField(
				text: $viewModel.surname,
				placeholder: String(localized: "placeholder_enter_last_name"),
				hasError: false)
		}
	}

	private var lastNameField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("label_middle_name")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			EventifyTextField(
				text: $viewModel.lastName.unwrapped(defaultValue: ""),
				placeholder: String(localized: "placeholder_enter_middle_name"),
				hasError: false)
		}
	}

	private var emailField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("email_placeholder")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			EventifyTextField(
				text: $viewModel.email,
				placeholder: String(localized: "placeholder_enter_email"),
				hasError: false
			)
			.disabled(true)
		}
	}

	private var telegramField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("label_telegram")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			EventifyTextField(
				text: $viewModel.telegram,
				placeholder: String(localized: "placeholder_enter_telegram"),
				hasError: false)
		}
	}

	private var categoriesSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("label_my_categories")
				.foregroundStyle(.mainText)
				.font(.mediumCompact(size: 20))

			Text("description_select_categories")
				.foregroundStyle(.secondaryText)
				.font(.regularCompact(size: 17))

			if categoriesModel.isLoading {
				// Показываем заглушки при загрузке
				HFlow {
					ForEach(0..<6) { _ in
						RoundedRectangle(cornerRadius: 24)
							.fill(Color.gray.opacity(0.3))
							.frame(width: 120, height: 45)
							.shimmer(isActive: true)
					}
				}
			} else {
				HFlow {
					ForEach(categoriesModel.categories) { category in
						PersonalCategoriesCheeps(
							viewModel: categoriesModel, category: category)
					}
				}
			}
		}
	}

	private var saveButton: some View {
		VStack(alignment: .center, spacing: 10) {
			EventifyButton(
				configuration: .saving,
				isLoading: false,
				isDisabled: false
			) {
				viewModel.patchUser()
				categoriesModel.setUserCategories()
			}
			.onChange(of: viewModel.shouldDismiss) { newValue in
				if newValue {
					coordinator.pop()
				}
			}
			.changeEffect(
				.glow,
				value: viewModel.isLoading
			)
			.changeEffect(
				.feedback(hapticImpact: .heavy),
				value: viewModel.shouldDismiss
			)
			.animation(.default, value: animation)
		}
	}
}
