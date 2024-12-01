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

	@StateObject private var viewModel: SearchViewModel

	init(viewModel: SearchViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
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
