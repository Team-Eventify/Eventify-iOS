//
//  EventsRegistationViewModel.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

final class EventsRegistrationViewModel: ObservableObject {
	@Published var register: Bool
	@Published var isRegistered: Bool = false
	@Published var currentPage: Int = 0
	@Published var name: String
	@Published var eventImages: [String]
	@Published var cheepsTitles: [String]
	@Published var description: String
	@Published var eventId: String?
	
	init(
		register: Bool,
		isRegistered: Bool,
		currentPage: Int,
		name: String,
		eventImages: [String],
		cheepsTitles: [String],
		description: String,
		eventId: String? = nil
	) {
		self.register = register
		self.isRegistered = isRegistered
		self.currentPage = currentPage
		self.name = name
		self.eventImages = eventImages
		self.cheepsTitles = cheepsTitles
		self.description = description
		self.eventId = eventId
	}
}
