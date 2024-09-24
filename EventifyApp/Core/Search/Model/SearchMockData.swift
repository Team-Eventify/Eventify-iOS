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
        .init(title: "Спорт", image: "sport", color: .sport),
        .init(title: "Наука", image: "science", color: .science),
        .init(title: "GameDev", image: "gameDev", color: .gameDev),
        .init(title: "Дизайн", image: "design", color: .design),
    ]

    /// Данные категорий для абитуриентов
    static let abiturientsData: [CategoriesModel] = [
        .init(title: "Экскурсии", image: "excursions", color: .excursions),
        .init(title: "Курсы", image: "courses", color: .courses),
        .init(title: "Олимпиады", image: "olimpiads", color: .olimpiads),
    ]
}
