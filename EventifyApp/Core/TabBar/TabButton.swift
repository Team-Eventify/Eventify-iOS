//
//  Tab.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//
import SwiftUI

/// Кнопка для переключения вкладок
struct TabButton: View {
	let item: Tab
	@EnvironmentObject private var coordinator: AppCoordinator
	
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
		.foregroundColor(coordinator.selectedTab == item ? Color.tabbatTint : Color.gray)
	}
	
	private func handleTabSelection() {
		withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
			coordinator.selectTab(item)
		}
	}
}
