//
//  MainViewModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI

/// ViewModel для главного экрана, управляет получением данных
final class MainViewModel: ObservableObject {
    /// Сервис управляющий евентами
    private let eventsService: EventsServiceProtocol

    init(eventsService: EventsServiceProtocol) {
        self.eventsService = eventsService
    }

    /// Возвращает данные популярных ивентов.
    func getPopularEventsData() -> [EventifyRecommendationModel] {
        return MainMockData.popularEvents
    }
    
    /// Возвращает категории на основе интересов.
    func interestsCategories() -> [CategoriesModel] {
        return MainMockData.categoriesBasedOnInterests
    }

    func fetchEventsList() {
        Task { @MainActor in
            let response = try await eventsService.listEvents()
			Logger.log(level: .network, "\(response)")
        }
    }
}
