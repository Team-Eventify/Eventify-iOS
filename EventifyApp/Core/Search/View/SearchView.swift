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

    @StateObject private var viewModel: SearchViewModel

    init(categoriesService: CategoriesService) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(categoriesService: categoriesService))
    }

	// MARK: - Body

	var body: some View {
			VStack {
				ScrollView(showsIndicators: false) {
                    let displayedResults = viewModel.isSearching ? viewModel.filteredResults : viewModel.searchData()
                    ForEach(displayedResults) {
                        EventifyCategories(configuration: $0.asDomain())
					}
				}
			}
            .onAppear {
                viewModel.fetchCategories()
            }
            .navigationTitle(String(localized: "tab_search"))
			.navigationBarTitleDisplayMode(.large)
			.padding(.horizontal, 16)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
			.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	TabBarView()
		.environmentObject(NetworkManager())
}
