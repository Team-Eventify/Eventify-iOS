//
//  MainViewModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI

/// ViewModel для главного экрана, управляет получением данных
final class HomeViewModel: ObservableObject {
	@Published var events: [EventifyRecommendationModel] = []
	var isLoading: Bool = false
	
	/// Сервис управляющий евентами
	private let eventService: EventServiceProtocol
	
	init(eventService: EventServiceProtocol) {
		self.eventService = eventService
		
		fetchEventsList()
	}
	
	/// Возвращает категории на основе интересов.
	func interestsCategories() -> [CategoriesModel] {
		return HomeMockData.categoriesBasedOnInterests
	}

	func fetchEventsList() {
		Task { @MainActor in
			do {
				isLoading = true
				let response = try await eventService.listEvents()
				self.events = response.map { eventsResponse in
					let startDate = Date(timeIntervalSince1970: TimeInterval(eventsResponse.start))
					let endDate = Date(timeIntervalSince1970: TimeInterval(eventsResponse.end))
					let (formattedDate, formattedTime) = startDate.formatForEvent(endDate: endDate)
					
					return EventifyRecommendationModel(
						id: eventsResponse.id,
						cover: eventsResponse.cover,
						image: ["example"],
						title: eventsResponse.title,
						description: eventsResponse.description,
						cheepsItems: [
							formattedDate,
							formattedTime,
							eventsResponse.location
						]
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

extension Date {
	func formatForEvent(endDate: Date) -> (date: String, time: String) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM"
		dateFormatter.locale = Locale(identifier: "ru_RU")
		
		let timeFormatter = DateFormatter()
		timeFormatter.dateFormat = "HH:mm"
		
		let formattedDate = dateFormatter.string(from: self)
		let formattedStartTime = timeFormatter.string(from: self)
		let formattedEndTime = timeFormatter.string(from: endDate)
		
		return (formattedDate, "\(formattedStartTime) - \(formattedEndTime)")
	}
}
