//
//  RecommendedEventsModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.07.2024.
//

import Foundation

/// Модель рекомммендуемых мероприятия
struct RecommendedEventsModel: Identifiable {
	/// Индификатор меропрития
	let id = UUID()

	/// Изображение меропрития
	let image: String

	/// Название мероприятия
	let title: String

	/// Заголовки тэгов мероприятия
	let cheepsItems: [String]
}
