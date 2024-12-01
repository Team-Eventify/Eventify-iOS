//
//  EventifyAppApp.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI

@main
struct EventifyApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	@StateObject private var networkManager = NetworkManager()
	@StateObject private var appCoordinator = AppCoordinator()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(networkManager)
				.environmentObject(appCoordinator)
		}
	}
}
