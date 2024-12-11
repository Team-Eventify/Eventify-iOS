//
//  MainView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

/// Вью Таб-бара
struct TabBarView: View {
	@StateObject private var homeVM: HomeViewModel
	@StateObject private var searchVM: SearchViewModel
	@StateObject private var myEventsVM: MyEventsViewModel
	@StateObject private var profileVM: ProfileViewModel
	
	@EnvironmentObject private var coordinator: AppCoordinator
	
	// MARK: - Initialization
	
	init(eventService: EventServiceProtocol, userService: UsersServiceProtocol) {
		_homeVM = StateObject(wrappedValue: HomeViewModel(eventService: eventService))
		_searchVM = StateObject(wrappedValue: SearchViewModel())
		_myEventsVM = StateObject(wrappedValue: MyEventsViewModel(usersService: userService))
		_profileVM = StateObject(wrappedValue: ProfileViewModel(userService: userService))
	}

	// MARK: - Body
	
	var body: some View {
		tabbarContent
			.environmentObject(homeVM)
			.environmentObject(searchVM)
			.environmentObject(myEventsVM)
			.environmentObject(profileVM)
			.navigationBarBackButtonHidden()
	}
}

private extension TabBarView {
	/// Содержимое таб-бара
	var tabbarContent: some View {
		VStack(spacing: 0) {
			coordinator.viewForSelectedTab()
				.frame(maxWidth: .infinity, maxHeight: .infinity)

			buttons
				.padding(.horizontal, 20)
				.padding(.top, 7)
				.frame(height: 83, alignment: .top)
				.cornerRadius(10, corners: [.topLeft, .topRight])
				.shadow(color: .white.opacity(0.15), radius: 1, x: 0, y: -0.33)
		}
		.ignoresSafeArea(edges: .bottom)
		.background(Color.tabbarBg)
	}

	/// Кнопки для всех вкладок
	var buttons: some View {
		HStack {
			ForEach(Tab.allCases, id: \.self) { item in
				TabButton(item: item)
			}
		}
	}
}
