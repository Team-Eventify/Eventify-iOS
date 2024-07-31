//
//  PersonalCategoriesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.07.2024.
//

import SwiftUI

@MainActor
final class PersonalCategoriesViewModel: ObservableObject {
	@Published var navigateWithCategories: Bool = false
	@Published var skipCategories: Bool = false
	@Published var selectedCategories: Set<PersonalCategories> = []
	@AppStorage("hasCategories") var hasCategories: Bool = false

	func toggleCategorySelection(_ category: PersonalCategories) {
		if selectedCategories.contains(category) {
			selectedCategories.remove(category)
		} else {
			selectedCategories.insert(category)
		}
	}

	var isAnyCategorySelected: Bool {
		!selectedCategories.isEmpty
	}
}
