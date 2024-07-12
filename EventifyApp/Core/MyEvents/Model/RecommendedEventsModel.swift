//
//  RecommendedEventsModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.07.2024.
//

import Foundation

struct RecommendedEventsModel: Identifiable {
	let id = UUID()
	let image: String
	let title: String
	let cheepsItems: [String]
}
