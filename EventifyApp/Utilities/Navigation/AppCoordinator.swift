//
//  AppCordinator.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 26.11.2024.
//

import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
	@Published var path: NavigationPath
	@Published var currentFlow: Flow = .auth

	let authProvider = AuthenticationProvider()
	var pathBinding: Binding<NavigationPath> {
		Binding(
			get: { self.path },
			set: { self.path = $0 }
		)
	}

	private var subscriptions = Set<AnyCancellable>()

	init(path: NavigationPath) {
		self.path = path
		observeAuth()
	}

	func observeAuth() {
		authProvider.$isAuthenticated.sink { [weak self] isAuthenticated in
			self?.currentFlow = isAuthenticated ? .main : .auth
		}
		.store(in: &subscriptions)
	}

	@ViewBuilder
	func build() -> some View {
		NavigationStack(path: pathBinding) {
			switch currentFlow {
			case .auth:
				let coordinator = AuthCoordinator(authProvider: authProvider)
				coordinator.build()
			case .main:
				let coordinator = MainTabCoordinator()
				coordinator.build(for: .main)
			}
		}
	}

	enum Flow {
		case auth
		case main
	}
}
