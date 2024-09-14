//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import SwiftUI
import SUINavigation

struct ContentView: View {
	@StateObject private var appColorScheme = AppColorScheme.shared
	@StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
		if profileViewModel.isLogin {
            NavigationViewStorage {
                TabBarView()
                    .environmentObject(profileViewModel)
                    .environmentObject(appColorScheme)
                    .preferredColorScheme(AppColorScheme.shared.selectedTheme == .light ? .light : .dark)
            }
		} else {
            NavigationViewStorage {
                SignUpView()
                    .environmentObject(profileViewModel)
                    .environmentObject(appColorScheme)
                    .preferredColorScheme(AppColorScheme.shared.selectedTheme == .light ? .light : .dark)
            }
		}
    }
}

#Preview {
    ContentView()
    
}
