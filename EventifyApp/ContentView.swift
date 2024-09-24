//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import SUINavigation
import SwiftUI

struct ContentView: View {
    @StateObject private var appColorScheme = AppColorScheme.shared
    @StateObject private var profileViewModel = ProfileViewModel()

    // Создаем экземпляры сервисов
    private let tokenService: TokenServiceProtocol = TokenService()
    
    var body: some View {
        if profileViewModel.isLogin {
            NavigationViewStorage {
                TabBarView()
                    .environmentObject(profileViewModel)
                    .environmentObject(appColorScheme)
                    .preferredColorScheme(
                        AppColorScheme.shared.selectedTheme == .light
                            ? .light : .dark)
            }
        } else {
            NavigationViewStorage {
                SignUpView(
                    signUpService: SignUpService()
                )
                .environmentObject(profileViewModel)
                .environmentObject(appColorScheme)
                .preferredColorScheme(
                    AppColorScheme.shared.selectedTheme == .light
                        ? .light : .dark)
            }
        }
    }
}

#Preview {
    ContentView()

}
