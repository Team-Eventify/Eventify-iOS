//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Модель предстоящих мероприятий
struct UpcomingEventsModel: Identifiable {
	/// Индификатор мероприятия
	let id = UUID()

	/// Название мероприятия
	let title: String

	/// Заголовки тэгов мероприятия
	let cheepTitles: [String]

	/// Цвет мероприятия
	let color: Color
}
