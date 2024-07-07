//
//  Search.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

struct SearchView: View {
	@StateObject var viewModel = SearchViewModel()

	var body: some View {
		NavigationStack {
			VStack {
				Picker("test", selection: $viewModel.selectedPicker) {
					Text("Для студентов").tag(0)
					Text("Для поступающих").tag(1)
				}
				.pickerStyle(.segmented)

				ScrollView(showsIndicators: false) {
					ForEach(viewModel.searchData()) {
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
}

#Preview {
	TabBarView()
}
