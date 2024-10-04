//
//  MainViewModel.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 03.10.2024.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    
    
    func getPopularEventsData() -> [EventifyRecommendationModel] {
        return MainMockData.popularEvents
    }
}
