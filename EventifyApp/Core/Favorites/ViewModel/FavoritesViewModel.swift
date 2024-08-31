//
//  FavoritesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.07.2024.
//

import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject {
	// MARK: - Public properties

	@Published var selectedPicker: Int = 0
	var showOrganizators: Bool = false

	// MARK: - Public Functions
	
	func favoritesData() -> [CellsModel] {
		if selectedPicker == 0 {
			showOrganizators = false
			return FavoritesMockData.eventsData
		} else {
			showOrganizators = true
			return FavoritesMockData.organizatorsData
		}
	}
}
