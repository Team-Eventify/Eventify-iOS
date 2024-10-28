//
//  Search.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью экрана Поиска
struct SearchView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel = SearchViewModel()
    private let categoriesService = CategoriesService()

	// MARK: - Body

	var body: some View {
			VStack {
				ScrollView(showsIndicators: false) {
                    let displayedResults = viewModel.isSearching ? viewModel.filteredResults : viewModel.searchData()
                    ForEach(displayedResults) {
						EventifyCategories(text: $0.title, image: $0.image, color: $0.color)
					}
				}
			}
            .onAppear {
                Task { @MainActor in
                    let response = try await categoriesService.getCategories()
                    Log.info("\(response)")
                }
            }
            .navigationTitle(NSLocalizedString("tab_search", comment: "Поиск"))
			.navigationBarTitleDisplayMode(.large)
			.padding(.horizontal, 16)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	TabBarView()
}
