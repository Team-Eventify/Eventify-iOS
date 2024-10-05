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
    let id = UUID()
    
    /// Изображение ячейки
    let image: String
    
    /// Заголовок события
    let title: String
    
    /// Описание события
    let description: String?
    
    /// Дополнительная информация (дата, время, формат)
    let cheepsItems: [String]
    
    /// Размер элемента, определённый через EventCellSize
    let size: EventCellSize
}

