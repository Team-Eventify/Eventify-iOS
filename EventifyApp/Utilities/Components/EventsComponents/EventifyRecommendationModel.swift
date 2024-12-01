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

	/// Изображение ячейки
	let image: [String]

	/// Заголовок события
	let title: String

	/// Описание события
	let description: String?

	/// Дополнительная информация (дата, время, формат)
	let cheepsItems: [String]

	/// Размер элемента, определённый через EventCellSize
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
}

extension EventifyRecommendationModel: DomainConvertable {
	typealias ConvertableType = RecommendationEventConfiguration

	func asDomain() -> ConvertableType {
		return RecommendationEventConfiguration(
			id: id,
			image: image,
			title: title,
			description: description,
			cheepsItems: cheepsItems,
			size: size
		)
	}
}
