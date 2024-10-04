//
//  MainViewModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI

/// ViewModel для главного экрана, управляет получением данных
@MainActor
final class MainViewModel: ObservableObject {
    
    /// Возвращает данные популярных ивентов.
    func getPopularEventsData() -> [EventifyRecommendationModel] {
        return MainMockData.popularEvents
    }
    
    /// Возвращает категории на основе интересов.
    func interestsCategories() -> [CategoriesModel] {
        return MainMockData.categoriesBasedOnInterests
    }
}
