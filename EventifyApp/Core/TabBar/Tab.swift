//
//  Tab.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//
import SwiftUI

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
            return "Главная"
        case .search:
            return "Поиск"
        case .myEvents:
            return "Мои ивенты"
        case .profile:
            return "Профиль"
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

/// Экраны вкладок
struct TabbarScreens: View {
    var contentMode: Tab

    @ViewBuilder
    var body: some View {
        switch contentMode {
        case .main: MainView()
        case .search: SearchView()
        case .myEvents: MyEventsView()
        case .profile: ProfileView()
        }
    }
}

/// Кнопка для переключения вкладок
struct TabButton: View {
    let item: Tab
    @Binding var selectedTab: Tab

    var body: some View {
        Button {
            handleTabSelection()
        } label: {
            VStack(spacing: 4) {
                SwiftUI.Image(systemName: item.icon)
                    .font(.title3)

                Text(item.title)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundColor(selectedTab == item ? Color.tabbatTint : Color.gray)
    }

    private func handleTabSelection() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedTab = item
        }
    }
}
