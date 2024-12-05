//
//  EventsRegistationViewModel.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

final class EventsRegistrationViewModel: ObservableObject {
	@Published var currentPage = 0
	@Published var isDescriptionExpanded = false
	
	private let eventService: EventServiceProtocol
	
	init(
		eventService: EventServiceProtocol
	) {
		self.eventService = eventService
	}
	
	func subscribe(eventId: String) async {
		do {
			let _ = try await eventService.subscribeForEvent(eventId: eventId)
		} catch {
			Logger.log(level: .error(error), "Error while subscribing for event")
		}
	}
}
