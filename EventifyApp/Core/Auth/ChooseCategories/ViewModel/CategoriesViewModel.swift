//
//  PersonalCategoriesViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.07.2024.
//

import SwiftUI

final class CategoriesViewModel: ObservableObject {
	@Published var selectedCategories: Set<String> = []
	@Published var categories: [Categories] = []
	@Published var isLoading: Bool = false

	private var authProvider: AuthenticationProviderProtocol?
	private let categoriesService: CategoryServiceProtocol
	private let userId = KeychainManager.shared.get(key: KeychainKeys.userId)

	init(categoriesService: CategoryServiceProtocol) {
		self.categoriesService = categoriesService
	}
	
	func initAuthProvider(authProvider: AuthenticationProviderProtocol) {
		self.authProvider = authProvider
	}
	
	func authenticate(coordinator: AppCoordinator) {
		authProvider?.authenticate()
		coordinator.flow = .main
	}

	func getCategories() {
		isLoading = true
		Task { @MainActor in
			do {
				let response = try await categoriesService.getCategories()
				self.categories = convertResponseToCategories(response)
				isLoading = false
				Logger.log(level: .info, "\(response)")
			} catch {
				isLoading = false
				Logger.log(level: .error(error), "Error while getting categories")
			}
		}
	}

	func getUserCategories() {
		isLoading = true
		Task { @MainActor in
			do {
				let response = try await categoriesService.getUserCategories(
					id: userId ?? "")
				self.selectedCategories = Set(response.map { $0.id })
				isLoading = false
				Logger.log(level: .info, "User categories: \(response)")
			} catch {
				isLoading = false
				Logger.log(level: .error(error), "Error while getting user categories")
			}
		}
	}

	func setUserCategories() {
		Task { @MainActor in
			do {
				let selectedCategoriesIds = Array(selectedCategories)
				let _ = try await categoriesService.setUserCategories(
					id: userId ?? "", categoriesIds: selectedCategoriesIds)
			} catch {
				Logger.log(level: .error(error), "Error while setting user categories")
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

extension CategoriesViewModel {
	private func convertResponseToCategories(
		_ response: CategoriesResponseModel
	) -> [Categories] {
		return response.map { Categories(id: $0.id, title: $0.title) }
	}
}
 
