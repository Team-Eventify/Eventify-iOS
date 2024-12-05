//
//  CoordinatorDestination.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 01.12.2024.
//

import SwiftUI

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
			case .profileDetail:
				ProfileDetailView()
			case .addEvent:
				AddEventView()
			case .notifications:
				NotificationUtilityView()
			case .feedback:
				FeedbackView()
			case .eventsDetail(let model, let eventsService):
				EventsRegistationView(model: model, eventService: eventsService)
			}
		}
	}
}
