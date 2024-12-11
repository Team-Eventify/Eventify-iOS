//
//  MyEventsViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 11.12.2024.
//

import Foundation

final class MyEventsViewModel: ObservableObject {
	@Published var eventsArray: [EventifyRecommendationModel] = []
	
	private let usersService: UsersServiceProtocol
	
	init(usersService: UsersServiceProtocol) {
		self.usersService = usersService
	}
	
	func fetchSubscribedEvents() {
		Task { @MainActor in
			do {
				guard let userId = KeychainManager.shared.get(key: KeychainKeys.userId) else { return }
				let response = try await usersService.getSubscribedEvents(id: userId)
				self.eventsArray = response.map { event in
					let startDate = Date(timeIntervalSince1970: TimeInterval(event.start))
					let endDate = Date(timeIntervalSince1970: TimeInterval(event.end))
					let (formattedDate, formattedTime) = startDate.formatForEvent(endDate: endDate)
					
					return EventifyRecommendationModel(
						id: event.id,
						image: ["example"],
						title: event.title,
						cheepsItems: [
							formattedDate,
							formattedTime,
							event.location
						],
						size: .large
					)
				}
			} catch {
				Logger.log(level: .error(error), "Error while subscribing for event")
			}
		}
	}
}
