//
//  RecommendationEventConfiguration.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 10.11.2024.
//

import Foundation

struct RecommendationEventConfiguration {
	/// Индификатор события
	let id: String

	/// Изображение для события.
	let image: [String]
	/// Заголовок события.
	let title: String
	/// Описание события.
	let description: String?
	/// Элементы для отображения (например, дата, время, формат).
	let cheepsItems: [String]
	/// Размер ячейки события.
	let size: EventCellSize

	init(
		id: String,
		image: [String],
		title: String,
		description: String? = nil,
		cheepsItems: [String],
		size: EventCellSize
	) {
		self.id = id
		self.image = image
		self.title = title
		self.description = description
		self.cheepsItems = cheepsItems
		self.size = size
	}

	var isFlexible: Bool {
		return size == .flexible
	}
}
