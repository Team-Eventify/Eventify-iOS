//
//  EventifyAppApp.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SUINavigation
import SwiftUI

@main
struct EventifyApp: App {
	var body: some Scene {
		WindowGroup {
			NavigationViewStorage {
				ContentView()
			}
		}
	}
}
