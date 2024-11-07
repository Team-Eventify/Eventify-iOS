//
//  Search.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI
import PopupView

/// Вью экрана Поиска
struct SearchView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel = SearchViewModel()
	@EnvironmentObject private var networkManager: NetworkManager

	private let categoriesService = CategoriesService()

	// MARK: - Body

	var body: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				let displayedResults =
					viewModel.isSearching
					? viewModel.filteredResults : viewModel.searchData()
				ForEach(displayedResults) {
					EventifyCategories(
						text: $0.title, image: $0.image, color: $0.color)
				}
			}
		}
		.onAppear {
			Task { @MainActor in
				let response = try await categoriesService.getCategories()
				Log.info("\(response)")
			}
		}
		.navigationTitle(String(localized: "tab_search"))
		.navigationBarTitleDisplayMode(.large)
		.padding(.horizontal, 16)
		.searchable(
			text: $viewModel.searchText,
			placement: .navigationBarDrawer(displayMode: .always)
		)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.popup(isPresented: $networkManager.isDisconnected) {
			InternetErrorToast()
		} customize: {
			$0.type(.toast)
				.disappearTo(.topSlide)
				.position(.top)
		}
	}
}

#Preview {
	TabBarView()
		.environmentObject(NetworkManager())
}
