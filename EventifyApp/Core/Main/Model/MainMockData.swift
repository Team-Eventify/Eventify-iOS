//
//  MainMockData.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import Foundation


struct MainMockData {
    static let popularEvents: [EventifyRecommendationModel] = [
        EventifyRecommendationModel(
            image: "recomm",
            title: "День открытых дверей",
            description: "Дни открытых дверей — это уникальная\nвозможность для старшеклассников больше\nузнать о специальностях, которым обучают\nв Унивеситете МИСИС.",
            cheepsItems: ["12 декабря", "17:30", "онлайн"],
            size: .flexible
        ),
        EventifyRecommendationModel(
            image: "recomm",
            title: "День открытых дверей",
            description: "Дни открытых дверей — это уникальная\nвозможность для старшеклассников больше\nузнать о специальностях, которым обучают\nв Унивеситете МИСИС.",
            cheepsItems: ["12 декабря", "17:30", "онлайн"],
            size: .flexible
        ),
        EventifyRecommendationModel(
            image: "recomm",
            title: "День открытых дверей",
            description: "Дни открытых дверей — это уникальная\nвозможность для старшеклассников больше\nузнать о специальностях, которым обучают\nв Унивеситете МИСИС.",
            cheepsItems: ["12 декабря", "17:30", "онлайн"],
            size: .flexible
        )
    ]
    
    static let categoriesBasedOnInterests: [CategoriesModel] = [
            .init(title: "Спорт", image: "sport", color: .sport),
            .init(title: "Наука", image: "science", color: .science),
            .init(title: "GameDev", image: "gameDev", color: .gameDev)
        ]
}
