//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

enum MyEventsMockData {
	static let upcomingEventsData: [UpcomingEventsModel] = [
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandPink),
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandYellow),
		.init(title: "День открытых дверей университета МИСИС", cheepTitles: ["12 декабря", "17:30", "онлайн"], color: .brandPink)
	]

	static let recommendedEventsData: [RecommendedEventsModel] = [
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"]),
		.init(image: "recomm",title: "День открытых дверей университета МИСИС", cheepsItems: ["12 декабря", "17:30", "онлайн"])
	]
}
