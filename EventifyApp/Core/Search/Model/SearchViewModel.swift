//
//  SearchViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
	// MARK: - Public Properties
    
    @Published private(set) var filteredResults: [CategoriesModel] = []
	@Published var searchText: String = ""
	@Published var selectedPicker: Int = 0
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscriber()
    }
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    private func addSubscriber() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.filterResults(by: newValue)
            }
            .store(in: &cancellables)
    }
    
    private func filterResults(by searchText: String) {
        guard !searchText.isEmpty else {
            filteredResults = []
            return
        }
        
        let search = searchText.lowercased()
        filteredResults = searchData().filter { result in
            let titleContainsSearch = result.title.lowercased().contains(search)
            return titleContainsSearch
        }
    }

	// MARK: - Public Functions
	
	func searchData() -> [CategoriesModel] {
			return SearchMockData.studentsData
	}
}
