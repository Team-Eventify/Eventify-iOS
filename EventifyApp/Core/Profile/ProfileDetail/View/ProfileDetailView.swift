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
        .init(title: "Имя", placeholder: "Имя"),
        .init(title: "Фамилия", placeholder: "Фамилия"),
        .init(title: "Отчество", placeholder: "Отчество"),
        .init(title: "Email", placeholder: "Email"),
        .init(title: "Telegram", placeholder: "Telegram"),
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
            Text("Имя")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.name, placeholder: "Введите имя",
                hasError: false)
        }
    }

    private var surnameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Фамилия")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.surname, placeholder: "Введите фамилию",
                hasError: false)
        }
    }

    private var lastNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Отчество")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.lastName.unwrapped(defaultValue: ""), placeholder: "Введите отчество",
                hasError: false)
        }
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.email, placeholder: "Введите Email",
                hasError: false)
            .disabled(true)
        }
    }

    private var telegramField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Telegram")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.telegram, placeholder: "Введите telegram",
                hasError: false)
        }
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Мои категории")
                .foregroundStyle(.mainText)
                .font(.mediumCompact(size: 20))

            Text("Выбирай категории ивентов под свои интересы!")
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
