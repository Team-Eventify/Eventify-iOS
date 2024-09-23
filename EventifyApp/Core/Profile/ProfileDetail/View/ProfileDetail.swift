//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import Pow
import SwiftUI

/// Вью детального экрана профиля
struct ProfileDetail: View {
    // MARK: - Private Properties

    @StateObject private var viewModel: ProfileDetailViewModel
    @StateObject private var categoriesModel: PersonalCategoriesViewModel
    @State private var animation: Bool = true

    @Environment(\.dismiss)
    var dismiss

    private let categories: [[PersonalCategories]] = [
        [
            .init(name: "Наука", selectionColor: .red),
            .init(name: "Спорт", selectionColor: .blue),
            .init(name: "Творчество", selectionColor: .green),
        ],
        [
            .init(name: "Дизайн", selectionColor: .yellow),
            .init(name: "Frontend", selectionColor: .orange),
            .init(name: "Mobile", selectionColor: .purple),
        ],
        [
            .init(name: "Backend", selectionColor: .pink),
            .init(name: "ML", selectionColor: .gray),
            .init(name: "GameDev", selectionColor: .brown),
            .init(name: "Media", selectionColor: .cyan),
        ],
        [
            .init(name: "Хакатоны", selectionColor: .mint),
            .init(name: "Театр", selectionColor: .teal),
            .init(name: "Наставничество", selectionColor: .science),
        ],
    ]

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
            wrappedValue: categoriesModel ?? PersonalCategoriesViewModel()
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
                text: $viewModel.name,
                placeholder: "Введите имя",
                isSecure: false
            )
        }
    }

    private var surnameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Фамилия")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.surname,
                placeholder: "Введите фамилию",
                isSecure: false
            )
        }
    }

    private var lastNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Отчество")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.lastName,
                placeholder: "Введите отчество",
                isSecure: false
            )
        }
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.email,
                placeholder: "Введите Email",
                isSecure: false)
        }
    }

    private var telegramField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Telegram")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.telegram,
                placeholder: "Введите telegram",
                isSecure: false
            )
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

            VStack(alignment: .leading, spacing: 10) {
                ForEach(categories.indices, id: \.self) { index in
                    HStack(spacing: 8) {
                        ForEach(categories[index].indices, id: \.self) {
                            inner in
                            PersonalCategoriesCheeps(
                                viewModel: categoriesModel,
                                category: categories[index][inner]
                            )
                        }
                    }
                }
            }
        }
    }

    private var saveButton: some View {
        VStack(alignment: .center, spacing: 10) {
            EventifyButton(
                title: "Сохранить изменения", isLoading: false,
                isDisabled: false
            ) {
                viewModel.patchUser()
                print("📙 Saved! 📙")
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
            .animation(.default, value: animation)
        }
    }
}

#Preview {
    ProfileDetail()
}
