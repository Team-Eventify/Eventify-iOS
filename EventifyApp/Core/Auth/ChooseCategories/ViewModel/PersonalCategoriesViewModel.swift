//
//  PersonalCategoriesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.07.2024.
//

import SwiftUI

final class PersonalCategoriesViewModel: ObservableObject {
	@Published var selectedCategories: Set<PersonalCategories> = []

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
