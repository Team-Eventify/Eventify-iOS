//
//  Tab.swift
//  EventifyApp
//
//  Created by Шарап Бамматов on 23.11.2024.
//

import Foundation

/// Вкладки приложения
enum Tab: CaseIterable, Hashable {
    /// Главный экран
    case main

    /// Экран "Поиск"
    case search

    /// Экран "Мои Ивенты"
    case myEvents

    /// Экран "Профиль"
    case profile

    /// Заголовок для каждой вкладки
    var title: String {
        switch self {
        case .main:
            return String(localized: "tab_main")
        case .search:
            return String(localized: "tab_search")
        case .myEvents:
            return String(localized: "tab_my_events")
        case .profile:
            return String(localized: "tab_profile")
        }
    }

    /// Иконка для каждой вкладки
    var icon: String {
        switch self {
        case .main:
            return "house"
        case .search:
            return "magnifyingglass"
        case .myEvents:
            return "bookmark"
        case .profile:
            return "person"
        }
    }
}
