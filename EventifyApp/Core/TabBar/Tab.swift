//
//  Tab.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//
import SwiftUI

enum Tab: CaseIterable, Hashable {
	case main
	case search
	case myEvents
	case favorites
	case profile

	var title: String {
		switch self {
			case .main: "Главная"
			case .search: "Поиск"
			case .myEvents: "Мои ивенты"
			case .favorites: "Избранное"
			case .profile: "Профиль"
		}
	}

	var icon: String {
		switch self {
			case .main: "house"
			case .search: "magnifyingglass"
			case .myEvents: "bookmark"
			case .favorites: "heart"
			case .profile: "person"
		}
	}
}

struct TabbarScreens: View {
	var contentMode: Tab

	@ViewBuilder
	var body: some View {
		switch contentMode {
			case .main:  MainView()
			case .search: SearchView()
			case .myEvents: MyEventsView()
			case .favorites: FavoritesView()
			case .profile: ProfileView()
		}
	}
}

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
