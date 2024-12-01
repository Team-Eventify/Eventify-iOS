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
	static let upcomingEventsData: [EventifyRecommendationModel] = [
		.init(
			id: "1",
			image: ["example", "example"],
			title: "Моковый заголовок #1",
			cheepsItems: ["1 декабря", "21:00", "Онлайн"],
			size: .large
		),
		.init(
			id: "2",
			image: ["example", "example"],
			title: "Моковый заголовок #2",
			cheepsItems: ["1 декабря", "22:00", "Онлайн"],
			size: .large
		),
		.init(
			id: "3",
			image: ["example", "example"],
			title: "Моковый заголовок #3",
			cheepsItems: ["1 декабря", "23:00", "Онлайн"],
			size: .large
		),
	]
	/// Рекоммендации мероприятия
	static let recommendedEventsData: [EventifyRecommendationModel] = [
		.init(
			id: "327eryf7823bedwnj",
			image: ["example"],
			title: "Фестиваль ИКН",
			cheepsItems: ["11 сентября", "18:00", "офлайн"],
			size: .large
		),
		.init(
			id: "23ye7wrdfy32hrejwd",
			image: ["example"],
			title: "ITAM courses",
			cheepsItems: ["27 сентября", "18:00", "Б-3"],
			size: .large
		),
	]
}
