//
//  MainMockData.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import Foundation

/// Моковые данные для главного экрана
struct MainMockData {
    
    /// Моковые данные популярных ивентов.
    static let popularEvents: [EventifyRecommendationModel] = [
        EventifyRecommendationModel(
            image: "recomm",
            title: "Битва роботов — сегодня!",
            description: "Команда СТИЛЕКС из Университета МИСИС выходит на арену «Битвы Роботов» и участвует в первом отборочном этапе этого сезона с роботом ЕЖК.",
            cheepsItems: ["28 сентября", "13:00", "онлайн"],
            size: .flexible
        ),
        EventifyRecommendationModel(
            image: "poster",
            title: "День открытых дверей",
            description: "Дни открытых дверей — это уникальная\nвозможность для старшеклассников больше\nузнать о специальностях, которым обучают\nв Унивеситете МИСИС.",
            cheepsItems: ["12 декабря", "17:30", "онлайн"],
            size: .flexible
        )
    ]
    
    /// Моковые данные категорий на основе интересов.
    static let categoriesBasedOnInterests: [CategoriesModel] = [
            .init(title: "Спорт", image: "sport", color: .sport),
            .init(title: "Наука", image: "science", color: .science),
            .init(title: "GameDev", image: "gameDev", color: .gameDev)
        ]
}
