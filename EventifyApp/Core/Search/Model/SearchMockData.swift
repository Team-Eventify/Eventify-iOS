//
//  SearchMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import Foundation

/// Моковые данные экрана Поиск
struct SearchMockData {

    /// Данные категорий для студентов
    static let studentsData: [CategoriesModel] = [
		.init(title: String(localized: "SportCategory"), image: "sport", color: .sport),
		.init(title: String(localized: "ScienceCategory"), image: "science", color: .science),
		.init(title: String(localized: "GameDevCategory"), image: "gameDev", color: .gameDev),
		.init(title: String(localized: "DesignCategory"), image: "design", color: .design),
		.init(title: String(localized: "ArtCategory"), image: "art", color: .art),
		.init(title: String(localized: "FrontendCategory"), image: "frontend", color: .frontend),
		.init(title: String(localized: "BackendCategory"), image: "backend", color: .backend)
    ]
}
