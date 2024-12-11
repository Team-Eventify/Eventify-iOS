//
//  AppCordinator.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 26.11.2024.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
	@Published var authPath = NavigationPath()
	@Published var mainPath = NavigationPath()
	@Published var selectedTab: Tab = .main
	
	@Published
	var flow: Flow = .auth {
		didSet {
			switch flow {
			case .auth:
				setAuthPath(NavigationPath())
			case .main:
				setMainPath(NavigationPath())
			}
		}
	}
	
	var authPathBinding: Binding<NavigationPath> {
		Binding(
			get: { self.authPath },
			set: { self.authPath = $0 }
		)
	}
	
	var mainPathBinding: Binding<NavigationPath> {
		Binding(
			get: { self.mainPath },
			set: { self.mainPath = $0 }
		)
	}
	
	let authProvider = AuthenticationProvider()
	
	private var subscriptions = Set<AnyCancellable>()
	
	init() {
		observeAuth()
		observeLogout()
	}
	
	@ViewBuilder
	func build() -> some View {
		switch flow {
		case .auth:
			NavigationStack(path: authPathBinding) {
				let authProvider = AuthenticationProvider()
				let authService = AuthService()
				let viewModel = SignUpViewModel(authService: authService, authProvider: authProvider)
				SignUpView(viewModel: viewModel).coordinatorDestination()
			}
		case .main:
			NavigationStack(path: mainPathBinding) {
				let eventsService = EventService()
				let userService = UsersService()
				TabBarView(eventService: eventsService, userService: userService).coordinatorDestination()
			}
		}
	}

	// Add this method to return the view for the selected tab
	 @ViewBuilder
	 func viewForSelectedTab() -> some View {
		 switch selectedTab {
		 case .main:
			 HomeView()
		 case .search:
			 SearchView()
		 case .profile:
			 ProfileView()
		 case .myEvents:
			 MyEventsView()
		 }
	 }

	 // Add this method to handle tab selection
	 func selectTab(_ tab: Tab) {
		 selectedTab = tab
	 }
	
	func observeAuth() {
		authProvider.$isAuthenticated.sink { [weak self] isAuthenticated in
			self?.flow = isAuthenticated ? .main : .auth
		}
		.store(in: &subscriptions)
	}
	
	func setMainPath(_ path: NavigationPath) {
		mainPath = path
	}
	
	func setAuthPath(_ path: NavigationPath) {
		authPath = path
	}
	
	enum Flow {
		case auth
		case main
	}
	
	private func observeLogout() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .logoutUser, object: nil)
	}

	@objc private func handleLogout() {
		DispatchQueue.main.async {
			self.flow = .auth
			self.authProvider.logout()
		}
	}
}

extension Notification.Name {
	static let logoutUser = Notification.Name("LogoutUser")
}
