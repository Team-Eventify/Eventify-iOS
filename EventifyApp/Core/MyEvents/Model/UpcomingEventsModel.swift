//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct UpcomingEventsModel: Identifiable {
	
	/// Индификатор мероприятия
	let id = UUID()
	
	/// Название мероприятия
	let title: String
	
	/// Заголовки тэгов мероприятия
	let cheepTitles: [String]
	
	/// Изображения мероприятия
	let eventImages: [String]
	
	/// Описание мероприятия
	let description: String
}
