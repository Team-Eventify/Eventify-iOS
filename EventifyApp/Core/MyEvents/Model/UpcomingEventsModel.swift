//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct UpcomingEventsModel: Identifiable {
	let id = UUID()
	let title: String
	let cheepTitles: [String]
	let color: Color
}
