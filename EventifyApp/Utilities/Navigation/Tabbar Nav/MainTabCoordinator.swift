//
//  MainTabCoordinator.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.11.2024.
//

import SwiftUI

class MainTabCoordinator: ObservableObject {
	@Published var selectedTab: Tab = .main
	
	@ViewBuilder
	func build(for tab: Tab) -> some View {
		switch tab {
		case .main:
			HomeCoordinator().build()
		case .search:
			HomeCoordinator().build()
		case .myEvents:
			HomeCoordinator().build()
		case .profile:
			HomeCoordinator().build()
		}
	}
}
