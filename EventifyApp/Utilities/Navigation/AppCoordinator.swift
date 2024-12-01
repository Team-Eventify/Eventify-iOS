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
	}
	
	@ViewBuilder
	func build() -> some View {
		switch flow {
		case .auth:
			NavigationStack(path: authPathBinding) {
				let authProvider = AuthenticationProvider()
				let signUpService = SignUpService()
				let viewModel = SignUpViewModel(signUpService: signUpService, authProvider: authProvider)
				SignUpView(viewModel: viewModel).coordinatorDestination()
			}
		case .main:
			NavigationStack(path: mainPathBinding) {
				let eventsService = EventsService()
				TabBarView(eventsService: eventsService)
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
			 let viewModel = SearchViewModel()
			 SearchView(viewModel: viewModel)
		 case .profile:
			 let userService = UserService()
			 let viewModel = ProfileViewModel(userService: userService)
			 ProfileView(viewModel: viewModel)
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
}

extension AppCoordinator {
	
	/// A list of possible navigation destinations in alphabetical order.
	enum Destination: Hashable {
		case empty
		case setCategories(CategoriesViewModel)
		case login(SignInViewModel)
		case forgotPassword(ForgotPasswordViewModel)
		case home
		case search(SearchViewModel)
		case myEvents
		case profile(ProfileViewModel)
		
		var id: String {
			`case`.id
		}
		
		static func == (lhs: Destination, rhs: Destination) -> Bool {
			lhs.id == rhs.id
		}

		/// The method MUST have the same implementation as its counterpart in Coordinator.Case
		func hash(into hasher: inout Hasher) {
			hasher.combine(id)
		}
	}
}

extension View {
	
	func coordinatorDestination() -> some View {
		navigationDestination(for: AppCoordinator.Destination.self) { screen in
			switch screen {
			case .empty:
				EmptyView()
			case .setCategories(let viewModel):
				PersonalCategoriesView(viewModel: viewModel)
			case .login(let viewModel):
				SignInView(viewModel: viewModel)
			case .forgotPassword(let viewModel):
				ForgotPasswordView(viewModel: viewModel)
			case .home:
				HomeView()
			case .search(let viewModel):
				SearchView(viewModel: viewModel)
			case .myEvents:
				MyEventsView()
			case .profile(let viewModel):
				ProfileView(viewModel: viewModel)
			}
		}
	}
}

extension AppCoordinator.Destination {
	
	var `case`: Case {
		switch self {
		case .empty:
			return .empty
		case .setCategories:
			return .setCategories
		case .login:
			return .login
		case .forgotPassword:
			return .forgotPassword
		case .home:
			return .home
		case .search:
			return .search
		case .myEvents:
			return .myEvents
		case .profile:
			return .profile
		}
	}
	
	enum Case: Hashable {
		case empty
		case setCategories
		case login
		case forgotPassword
		case home
		case search
		case myEvents
		case profile

		var id: String {
			String(describing: self)
		}
		
		static func == (lhs: Case, rhs: Case) -> Bool {
			lhs.id == rhs.id
		}
		
		/// The method MUST have the same implementation as its counterpart in Coordinator.Destination
		func hash(into hasher: inout Hasher) {
			hasher.combine(id)
		}
	}
}

extension AppCoordinator {

	private var path: NavigationPath {
		get {
			switch flow {
			case .auth:
				return authPath
			case .main:
				return mainPath
			}
		}
		set {
			switch flow {
			case .auth:
				setAuthPath(newValue)
			case .main:
				setMainPath(newValue)
			}
		}
	}

	/// Sets new screens onto the navigation stack inside the current story.
	nonisolated func setDestinations(_ destinations: [AppCoordinator.Destination]) {
		DispatchQueue.main.async {
			self.path = NavigationPath(destinations)
		}
	}

	/// Pushes one screen onto the navigation stack inside the current story.
	nonisolated func push(_ destination: AppCoordinator.Destination) {
		DispatchQueue.main.async {
			self.path.append(destination)
		}
	}

	/// Removes all screens from the navigation stack inside the current story.
	nonisolated func popToRoot() {
		DispatchQueue.main.async {
			self.path = NavigationPath()
		}
	}

	/// Removes one screen from navigation stack inside the current story.
	nonisolated func pop(_ count: Int = 1) {
		DispatchQueue.main.async {
			self.path.removeLast(count)
		}
	}

	/// Pops screens until the specified screen is at the top of the navigation stack inside the current story.
	/// Heavily relies on the fact that Coordinator.Case and Coordinator.Destination have the same hashable value.
	nonisolated func pop(to destination: AppCoordinator.Destination.Case) {
		DispatchQueue.main.async {
			while !self.path.isEmpty {
				self.path.removeLast()
				if self.path.count == destination.hashValue {
					break
				}
			}
		}
	}
}
