//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью главного экрана
struct MainView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = MainViewModel()
    
	// MARK: - Body
    
    private let categoriesService: CategoriesServiceProtocol
    
    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }

    var body: some View {
        ScrollView {
            Section {
                Text("Популярные ивенты")
                    .font(.mediumCompact(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            LazyVStack(spacing: 30) {
                ForEach(viewModel.getPopularEventsData()) {
                    EventifyRecommendationEvent(image: $0.image, title: $0.title, description: $0.description, cheepsItems: $0.cheepsItems, size: $0.size)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
        .navigationTitle("Главная")
        .navigationBarTitleDisplayMode(.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg, ignoresSafeAreaEdges: .all)
        .onAppear {
            Task { @MainActor in
                let response = try await categoriesService.getCategories()
                Log.info("\(response)")
            }
        }
    }
}

#Preview {
    MainView(categoriesService: CategoriesService())
}
