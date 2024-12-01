//
//  AppCoordinator + path.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 01.12.2024.
//

import SwiftUI

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
