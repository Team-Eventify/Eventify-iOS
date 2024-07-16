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
	@StateObject private var appColorScheme = AppColorScheme.shared
	@StateObject private var profileViewModel = ProfileViewModel()
	@AppStorage("isLogin") var isLogin: Bool = false
	var body: some Scene {
		WindowGroup {
			NavigationViewStorage {
				if isLogin {
					TabBarView()
						.environmentObject(profileViewModel)
						.environmentObject(appColorScheme)
						.preferredColorScheme(appColorScheme.colorScheme)
				} else {
					SignUpView()
						.environmentObject(profileViewModel)
						.environmentObject(appColorScheme)
						.preferredColorScheme(appColorScheme.colorScheme)
				}
			}
		}
	}
}
