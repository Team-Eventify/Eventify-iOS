//
//  CategoriesModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Модель категорий
struct CategoriesModel: Identifiable {
	///
	let id = UUID()

	/// Заголовок категории
	let title: String

	/// Изображение  категории
	let image: String

	/// Цвет категории
	let color: Color
}

extension CategoriesModel: DomainConvertable {
    func asDomain() -> CategoriesConfiguration {
        CategoriesConfiguration(
            text: title,
            image: image,
            color: color
        )
    }
}
