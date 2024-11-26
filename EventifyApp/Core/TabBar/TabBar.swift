//
//  MainView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

/// Вью Таб-бара
struct TabBarView: View {
	// MARK: - Private Properties
	@StateObject private var vm: MainViewModel
	@StateObject private var searchVM: SearchViewModel
	@ObservedObject var coordinator: MainTabCoordinator
	
	init(eventsService: EventsServiceProtocol, coordinator: MainTabCoordinator) {
		_coordinator = ObservedObject(wrappedValue: coordinator)
		_vm = StateObject(wrappedValue: MainViewModel(eventsService: eventsService))
		_searchVM = StateObject(wrappedValue: SearchViewModel())
	}
	
	// MARK: - Body
	
	var body: some View {
		tabbarContent
			.navigationBarBackButtonHidden()
	}
}

private extension TabBarView {
	/// Содержимое таб-бара
	var tabbarContent: some View {
		VStack(spacing: 0) {
			TabbarScreens(contentMode: $coordinator.selectedTab, mainTabCoordinator: coordinator)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.environmentObject(vm)
				.environmentObject(searchVM)

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
				TabButton(item: item, selectedTab: $coordinator.selectedTab)
			}
		}
	}
}
