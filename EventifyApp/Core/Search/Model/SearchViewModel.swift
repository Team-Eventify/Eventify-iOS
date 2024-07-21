//
//  SearchViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var searchText: String = ""
	@Published var selectedPicker: Int = 0

	// MARK: - Public Functions
	
	func searchData() -> [CategoriesModel] {
		if selectedPicker == 0 {
			return SearchMockData.studentsData
		} else {
			return SearchMockData.abiturientsData
		}

	}
}
