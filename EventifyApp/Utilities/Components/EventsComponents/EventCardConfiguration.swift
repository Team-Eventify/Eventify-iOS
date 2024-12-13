//
//  RecommendationEventConfiguration.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 10.11.2024.
//

import Foundation

struct EventCardConfiguration {
	/// Индификатор события
	let id: String

	let cover: String
	
	/// Изображение для события.
	let image: [String]
	/// Заголовок события.
	let title: String
	/// Описание события.
	let description: String?
	
	/// Элементы для отображения (например, дата, время, формат).
	let cheepsItems: [String]

	init(
		id: String,
		cover: String,
		image: [String],
		title: String,
		description: String? = nil,
		cheepsItems: [String]
	) {
		self.id = id
		self.cover = cover
		self.image = image
		self.title = title
		self.description = description
		self.cheepsItems = cheepsItems
	}
}
