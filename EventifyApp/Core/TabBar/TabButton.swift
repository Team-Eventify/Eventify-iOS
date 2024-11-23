//
//  Tab.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//
import SwiftUI

/// Экраны вкладок
struct TabbarScreens: View {
    @Binding var contentMode: Tab

    @ViewBuilder
    var body: some View {
        switch contentMode {
        case .main: MainView()
        case .search: SearchView(categoriesService: CategoriesService())
        case .myEvents: MyEventsView()
		case .profile: ProfileView(userService: UserService())
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
