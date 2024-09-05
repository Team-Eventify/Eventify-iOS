//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Мок-данные для экрана "Мои Мероприятия"
enum MyEventsMockData {

	/// Предстоящие мероприятия
	static let upcomingEventsData: [UpcomingEventsModel] = [
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandPink),
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandYellow),
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandPink)
	]

	/// Рекоммендации мероприятия
	static let recommendedEventsData: [CellsModel] = [
		.init(image: "recomm",title: "Фестиваль ИКН", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"])
	]
}
