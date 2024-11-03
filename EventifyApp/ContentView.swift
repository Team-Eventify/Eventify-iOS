//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var profileViewModel = ProfileViewModel(userService: UserService())

    // Создаем экземпляры сервисов
    private let tokenService: TokenServiceProtocol = TokenService()

    var body: some View {
        if profileViewModel.isLogin {
			NavigationStack {
                TabBarView()
                    .environmentObject(profileViewModel)
            }
        } else {
			NavigationStack {
                SignUpView(
                    signUpService: SignUpService()
                )
                .environmentObject(profileViewModel)
            }
        }
    }
}

#Preview {
    ContentView()

}
