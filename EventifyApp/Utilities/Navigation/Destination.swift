//
//  Destionation.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 01.12.2024.
//

import Foundation

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
		case profileDetail
		case addEvent
		case notifications
		case feedback
		case eventsDetail(EventifyRecommendationModel)
		
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
		case .profileDetail:
			return .profileDetail
		case .addEvent:
			return .addEvent
		case .notifications:
			return .notifications
		case .feedback:
			return .feedback
		case .eventsDetail:
			return .myEventDetail
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
		case profileDetail
		case addEvent
		case notifications
		case feedback
		case myEventDetail

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
