//
//  EventifyRecommendationModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI

/// Модель рекомендационных ячеек главного экрана
struct EventifyRecommendationModel: Identifiable {

	/// Уникальный идентификатор для соответствия протоколу Identifiable
	let id: String
	
	let cover: String

	/// Изображение ячейки
	let image: [String]

	/// Заголовок события
	let title: String

	/// Описание события
	let description: String?

	/// Дополнительная информация (дата, время, формат)
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

extension EventifyRecommendationModel: DomainConvertable {
	typealias ConvertableType = EventCardConfiguration

	func asDomain() -> ConvertableType {
		return EventCardConfiguration(
			id: id,
			cover: cover,
			image: image,
			title: title,
			description: description,
			cheepsItems: cheepsItems
		)
	}
}
