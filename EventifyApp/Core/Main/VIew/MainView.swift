//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI
import TelemetryDeck

/// Вью главного экрана
struct MainView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = MainViewModel()
    @Binding private var selectedTab: Tab
    
	// MARK: - Body
    
    private let eventsServive: EventsServiceProtocol
    
    /// Инициализирует MainView с сервисом категорий и привязкой активной вкладки
    init(eventsService: EventsServiceProtocol, selectedTab: Binding<Tab>) {
        self.eventsServive = eventsService
        self._selectedTab = selectedTab
    }

    var body: some View {
        ScrollView {
            popularEventsSection
            categoriesSection
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
        .navigationTitle("Главная")
        .navigationBarTitleDisplayMode(.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg, ignoresSafeAreaEdges: .all)
        .onAppear {
            Task { @MainActor in
                let response = try await eventsServive.listEvents()
                Log.info("\(response)")
            }
            TelemetryDeck.signal("Main Screen opened!")
        }
    }
    
    private var popularEventsSection: some View {
        VStack {
            Text("Популярные ивенты")
                .font(.mediumCompact(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            LazyVStack(spacing: 30) {
                ForEach(viewModel.getPopularEventsData()) {
                    EventifyRecommendationEvent(image: $0.image, title: $0.title, description: $0.description, cheepsItems: $0.cheepsItems, size: $0.size)
                }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
    private var categoriesSection: some View {
        VStack {
            Text("Категории на основе твоих интересов")
                .font(.mediumCompact(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVStack(spacing: 10) {
                ForEach(viewModel.interestsCategories()) {
                    EventifyCategories(text: $0.title, image: $0.image, color: $0.color)
                }
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = .search
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text("Посмотреть больше категорий")
                            .font(.mediumCompact(size: 14))
                            .bold()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.accent)
                }
            }
        }
        .padding(.bottom, 20)
    }
    
}

#Preview {
    MainView(eventsService: EventsService(), selectedTab: .constant(.main))
}