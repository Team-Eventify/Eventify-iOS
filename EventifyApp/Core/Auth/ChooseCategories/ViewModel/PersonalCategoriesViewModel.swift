//
//  PersonalCategoriesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.07.2024.
//

import SwiftUI

final class PersonalCategoriesViewModel: ObservableObject {
	@Published var selectedCategories: Set<PersonalCategories> = []
    var categories: [PersonalCategories] = []
    
    private let categoriesService: CategoriesServiceProtocol
    
    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }
    
    func getCategories() {
        Task { @MainActor in
            do {
                let response = try await categoriesService.getCategories()
                print(response)
            }
        }
    }

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
