//
//  Search.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import PopupView
import SwiftUI

/// Вью экрана Поиска
struct SearchView: View {
	// MARK: - Private Properties

    // TODO: сделать EnvironmentObject 
	@StateObject private var viewModel: SearchViewModel

	init(categoriesService: CategoriesService) {
		_viewModel = StateObject(
			wrappedValue: SearchViewModel(categoriesService: categoriesService))
	}

	// MARK: - Body

	var body: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				let displayedResults =
					viewModel.isSearching
					? viewModel.filteredResults : viewModel.searchData()
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

