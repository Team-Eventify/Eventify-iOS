//
//  Favorites.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью экрана "Избранное"
struct FavoritesView: View {
	// MARK: - Public Properties

	@StateObject private var viewModel = FavoritesViewModel()

	// MARK: - Body

	var body: some View {
			VStack(alignment: .leading, spacing: 28) {
				Picker("", selection: $viewModel.selectedPicker) {
					Text("Ивенты").tag(0)
					Text("Организаторы").tag(1)
				}
				.pickerStyle(.segmented)
				ScrollView(showsIndicators: false) {
					LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
						ForEach(viewModel.favoritesData()) {
							if viewModel.showOrganizators {
								EventifyFavoriteOrganizators(
									image: $0.image,
									name: $0.title,
									size: .slim,
									items: $0.cheepsItems
								)
							} else {
								EventifyRecommendationEvent(
									image: $0.image,
									title: $0.title,
									cheepsItems: $0.cheepsItems,
									size: .slim
								)
							}
						}
					}
					recomendedEvents
					Spacer()
				}
			}
		.navigationTitle("Избранное")
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg)
	}
}

// MARK: - UI Components

/// Рекоммендуемые меропрятия
private var recomendedEvents: some View {
	VStack(alignment: .leading) {
		Text("Рекомедации")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 8) {
				ForEach(FavoritesMockData.recomendedEventsData) {
					EventifyRecommendationEvent(
						image: $0.image,
						title: $0.title,
						cheepsItems: $0.cheepsItems,
						size: .large
					)
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		TabBarView()
	}
}