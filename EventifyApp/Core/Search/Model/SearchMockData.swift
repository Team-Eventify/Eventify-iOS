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
        .init(title: "Творчество", image: "art", color: .art),
        .init(title: "Frontend", image: "frontend", color: .frontend),
        .init(title: "Backend", image: "backend", color: .backend),
        .init(title: "Machine\nLearning", image: "machineLearning", color: .ML),
        .init(title: "Медиа", image: "media", color: .media),
        .init(title: "Хакатоны", image: "hackathons", color: .hackatons),
        .init(title: "Студенческая\nжизнь", image: "studentLife", color: .studLife),
        .init(title: "Наставничество", image: "mentoring", color: .mentoring)
    ]
}
