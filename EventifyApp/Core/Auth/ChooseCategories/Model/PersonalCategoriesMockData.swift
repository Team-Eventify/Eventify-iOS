//
//  PersonalCategoriesMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import Foundation

enum PersonalCategoriesMockData {
    static let categories: [PersonalCategories] = [
        .init(name: "Наука", selectionColor: .science),
        .init(name: "Спорт", selectionColor: .sport),
        .init(name: "Творчество", selectionColor: .art),
        .init(name: "Дизайн", selectionColor: .design),
        .init(name: "Frontend", selectionColor: .frontend),
        .init(name: "Backend", selectionColor: .backend),
        .init(name: "ML", selectionColor: .ML),
        .init(name: "GameDev", selectionColor: .gameDev),
        .init(name: "Media", selectionColor: .media),
        .init(name: "Хакатоны", selectionColor: .hackatons),
        .init(name: "Наставничество", selectionColor: .mentoring),
        .init(name: "Студенческая жизнь", selectionColor: .studLife)
    ]
}
