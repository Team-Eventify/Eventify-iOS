//
//  ChooseCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import SwiftUI
import SUINavigation

struct PersonalCategoriesView: View {
	// MARK: - Private Properties

	/// ViewModel для управления логикой вью
	@StateObject private var viewModel: PersonalCategoriesViewModel

	init(viewModel: PersonalCategoriesViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? PersonalCategoriesViewModel()
		)
	}

	private let categories: [[PersonalCategories]] = [
		[
			.init(name: "Наука", selectionColor: .red),
			.init(name: "Спорт", selectionColor: .blue),
			.init(name: "Творчество", selectionColor: .green)
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
			.init(name: "Аналитика", selectionColor: .indigo),
			.init(name: "Хакатоны", selectionColor: .mint),
			.init(name: "Театр", selectionColor: .teal)
		],
		[
			.init(name: "Наставничество", selectionColor: .science),
			.init(name: "Студенческая жизнь", selectionColor: .sport),
		],
	]

	// MARK: - Body

	var body: some View {
		VStack(alignment: .leading, spacing: 40) {
			Spacer()
			headerContainer

			VStack(alignment: .leading, spacing: 8) {
				ForEach(categories.indices, id: \.self) { index in
					HStack(spacing: 8) {
						ForEach(categories[index].indices, id: \.self) { inner in
							PersonalCategoriesCheeps(
								viewModel: viewModel,
								category: categories[index][inner]
							)
						}
					}
				}
			}
			Text("Ты всегда сможешь изменить свой выбор в настройках.")
				.font(.regularCompact(size: 17))
				.foregroundStyle(.secondaryText)

			footerContainer

			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(.horizontal, 16)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.navigationBarBackButtonHidden()

		.navigation(isActive: $viewModel.navigateWithCategories) {
			TabBarView()
		}

		.navigation(isActive: $viewModel.skipCategories) {
			TabBarView()
		}
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

	private var footerContainer: some View {
		VStack(spacing: 24) {
			EventifyButton(title: "Далее", isLoading: false, isDisabled: !viewModel.isAnyCategorySelected) {
				viewModel.navigateWithCategories.toggle()
				viewModel.hasCategories.toggle()
			}

			Button {
				viewModel.skipCategories.toggle()
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
