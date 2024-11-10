//
//  MainViewModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI


/// ViewModel для главного экрана, управляет получением данных
final class MainViewModel: ObservableObject {
	
	var events: [EventifyRecommendationModel] = []
	var isLoading: Bool = false

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
			do {
				isLoading = true
				let response = try await eventsService.listEvents()
				self.events = response.map { eventsResponse in
					EventifyRecommendationModel(
						id: eventsResponse.id,
						image: "wakeup",
						title: eventsResponse.title,
						description: eventsResponse.description,
						cheepsItems: ["10 ноября", "15:00", "Онлайн"],
						size: .flexible
					)
				}
				isLoading = false
				Logger.log(level: .network, "\(response)")
			} catch {
				isLoading = true
				Logger.log(level: .error(error), "")
			}
		}
	}
}
