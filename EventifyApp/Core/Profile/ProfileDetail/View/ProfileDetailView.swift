//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI
import Flow
import Pow
import PopupView

/// Вью детального экрана профиля
struct ProfileDetailView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel: ProfileDetailViewModel
	@StateObject private var categoriesModel: PersonalCategoriesViewModel
	@EnvironmentObject private var networkManager: NetworkManager

	@State private var animation: Bool = true

	@Environment(\.dismiss)
	var dismiss

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter viewModel: модель детального экрана профиля
	init(
		viewModel: ProfileDetailViewModel? = nil,
		categoriesModel: PersonalCategoriesViewModel? = nil
	) {
		_viewModel = StateObject(
			wrappedValue: viewModel
				?? ProfileDetailViewModel(userService: UserService())
		)
		_categoriesModel = StateObject(
			wrappedValue: categoriesModel
				?? PersonalCategoriesViewModel(
					categoriesService: CategoriesService())
		)
	}

	// MARK: - Body

	var body: some View {
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
			.popup(isPresented: $networkManager.isDisconnected) {
				InternetErrorToast()
			} customize: {
				$0.type(.toast)
					.disappearTo(.topSlide)
					.position(.top)
					.isOpaque(true)
			}
		}
		.background(.bg, ignoresSafeAreaEdges: .all)
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
					dismiss()
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

#Preview {
	ProfileDetailView()
		.environmentObject(NetworkManager())
}
