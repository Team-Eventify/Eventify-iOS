//
//  FavoritesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.07.2024.
//

import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject {
	@Published var selectedPicker: Int = 0

	func favoritesData() -> [RecommendedEventsModel] {
		if selectedPicker == 0 {
			return FavoritesMockData.eventsData
		} else {
			return FavoritesMockData.recomendedEventsData
		}
	}
}
