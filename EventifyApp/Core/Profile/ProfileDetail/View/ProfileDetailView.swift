//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import Flow
import Pow
import SwiftUI

/// Вью детального экрана профиля
struct ProfileDetailView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel: ProfileDetailViewModel
    @StateObject private var categoriesModel: PersonalCategoriesViewModel
    @State private var animation: Bool = true

    @Environment(\.dismiss)
    var dismiss

    private let textFieldSections: [ProfileTextFieldModel] = [
        .init(title: NSLocalizedString("label_first_name", comment: "Имя"), placeholder: NSLocalizedString("label_first_name", comment: "Имя")),
        .init(title: NSLocalizedString("label_last_name", comment: "Фамилия"), placeholder: NSLocalizedString("label_last_name", comment: "Фамилия")),
        .init(title: NSLocalizedString("label_middle_name", comment: "Отчество"), placeholder: NSLocalizedString("label_middle_name", comment: "Отчество")),
        .init(title: NSLocalizedString("label_email", comment: "Email"), placeholder: NSLocalizedString("label_email", comment: "Email")),
        .init(title: NSLocalizedString("label_telegram", comment: "Telegram"), placeholder: NSLocalizedString("label_telegram", comment: "Telegram"))
    ]

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
            .onAppear {
                viewModel.getUser()
                categoriesModel.getCategories()
                categoriesModel.getUserCategories()
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg, ignoresSafeAreaEdges: .all)
    }

    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("label_first_name")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.name, placeholder: NSLocalizedString("placeholder_enter_first_name", comment: "Введите имя"),
                hasError: false)
        }
    }

    private var surnameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("label_last_name")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.surname, placeholder: NSLocalizedString("placeholder_enter_last_name", comment: "Введите фамилию"),
                hasError: false)
        }
    }

    private var lastNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("label_middle_name")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.lastName.unwrapped(defaultValue: ""), placeholder: NSLocalizedString("placeholder_enter_middle_name", comment: "Введите отчество"),
                hasError: false)
        }
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("label_email")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.email, placeholder: NSLocalizedString("placeholder_enter_email", comment: "Введите Email"),
                hasError: false)
            .disabled(true)
        }
    }

    private var telegramField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("label_telegram")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.telegram, placeholder: NSLocalizedString("placeholder_enter_telegram", comment: "Введите telegram"),
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
}
