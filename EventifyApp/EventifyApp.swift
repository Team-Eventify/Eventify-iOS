//
//  EventifyAppApp.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI

@main
struct EventifyApp: App {
	@StateObject private var networkManager = NetworkManager()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(networkManager)
        }
    }
}
//
