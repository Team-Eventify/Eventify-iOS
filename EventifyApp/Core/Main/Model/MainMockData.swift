//
//  MainMockData.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import Foundation

/// Моковые данные для главного экрана
struct MainMockData {

	/// Моковые данные категорий на основе интересов.
	static let categoriesBasedOnInterests: [CategoriesModel] = [
		.init(title: "Спорт", image: "sport", color: .sport),
		.init(title: "Наука", image: "science", color: .science),
		.init(title: "GameDev", image: "gamedev", color: .gameDev),
	]
}
