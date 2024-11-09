//
//  PersonalCategoriesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.07.2024.
//

import SwiftUI

final class PersonalCategoriesViewModel: ObservableObject {
    @Published var selectedCategories: Set<String> = []
    @Published var categories: [Categories] = []
    @Published var isLoading: Bool = false
    
    private let categoriesService: CategoriesServiceProtocol
    private let userId = KeychainManager.shared.get(key: KeychainKeys.userId)
    
    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }
    
    func getCategories() {
        isLoading = true
        Task { @MainActor in
            do {
                let response = try await categoriesService.getCategories()
                self.categories = convertResponseToCategories(response)
                isLoading = false
                Log.log(level: .info, "\(response)")
            } catch {
                isLoading = false
                Log.log(level: .error(error), "Error while getting categories")
            }
        }
    }
    
    func getUserCategories() {
        isLoading = true
        Task { @MainActor in
            do {
                let response = try await categoriesService.getUserCategories(id: userId ?? "")
                self.selectedCategories = Set(response.map { $0.id })
                isLoading = false
                Log.info("User categories: \(response)")
            } catch {
                isLoading = false
                Log.log(level: .error(error), "Error while getting user categories")
            }
        }
    }
    
    func setUserCategories() {
        Task { @MainActor in
            do {
                let selectedCategoriesIds = Array(selectedCategories)
                let _ = try await categoriesService.setUserCategories(id: userId ?? "", categoriesIds: selectedCategoriesIds)
            } catch {
                Log.error("Error while setting user categories", error: error)
            }
        }
    }

    func toggleCategorySelection(_ category: Categories) {
        if selectedCategories.contains(category.id) {
            selectedCategories.remove(category.id)
		} else {
            selectedCategories.insert(category.id)
		}
	}

	var isAnyCategorySelected: Bool {
		!selectedCategories.isEmpty
	}
}

extension PersonalCategoriesViewModel {
    private func convertResponseToCategories(_ response: CategoriesResponseModel) -> [Categories] {
        return response.map { Categories(id: $0.id, title: $0.title) }
    }
}
