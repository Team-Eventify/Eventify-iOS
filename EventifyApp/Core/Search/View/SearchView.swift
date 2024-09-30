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

	// MARK: - Body

	var body: some View {
			VStack {
				Picker("", selection: $viewModel.selectedPicker) {
					Text("Для студентов").tag(0)
					Text("Для поступающих").tag(1)
				}
				.pickerStyle(.segmented)

				ScrollView(showsIndicators: false) {
                    let displayedResults = viewModel.isSearching ? viewModel.filteredResults : viewModel.searchData()
                    ForEach(displayedResults) {
						EventifyCategories(text: $0.title, image: $0.image, color: $0.color)
					}
				}
			}
			.navigationTitle("Поиск")
			.navigationBarTitleDisplayMode(.large)
			.padding(.horizontal, 16)
			.searchable(text: $viewModel.searchText)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
//	TabBarView()
    NavigationStack {
        SearchView()
    }
}
