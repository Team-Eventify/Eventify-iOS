//
//  ChooseCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Flow
import SwiftUI

struct PersonalCategoriesView: View {
    // MARK: - Private Properties
    
    /// ViewModel для управления логикой вью
    @StateObject private var viewModel: PersonalCategoriesViewModel

    init(viewModel: PersonalCategoriesViewModel? = nil) {
        _viewModel = StateObject(
            wrappedValue: viewModel ?? PersonalCategoriesViewModel(categoriesService: CategoriesService())
        )
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Spacer()
            headerContainer
            cheepsSection
            descriptionSection
            footerContainer
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(.bg, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden()
    }

    private var headerContainer: some View {
        VStack(alignment: .leading, spacing: 21) {
            Text("Выбери интересные\nтебе категории!")
                .font(.mediumCompact(size: 35))
                .foregroundStyle(.mainText)

            Text("Мы подберём рекомендации ивентов\nпод твои вкусы.")
                .font(.regularCompact(size: 17))
                .foregroundStyle(.secondaryText)
        }
    }

    private var cheepsSection: some View {
        HFlow {
            ForEach(PersonalCategoriesMockData.categories, id: \.self) {
                index in
                PersonalCategoriesCheeps(viewModel: viewModel, category: index)
            }
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Ты всегда сможешь изменить свой выбор в настройках.")
                .font(.regularCompact(size: 17))
                .foregroundStyle(.secondaryText)
        }
    }

    private var footerContainer: some View {
        VStack(spacing: 24) {
            EventifyButton(
                configuration: .commom, isLoading: false,
                isDisabled: !viewModel.isAnyCategorySelected
            ) {
                Constants.hasCategories = true
                Constants.isLogin = true
            }

            Button {
                Constants.isLogin = true
            } label: {
                Text("Пропустить")
                    .foregroundStyle(.gray)
                    .font(.mediumCompact(size: 17))
                    .underline()
            }
        }
    }
}

#Preview {
    PersonalCategoriesView()
}
