//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import PopupView
import SwiftUI

struct ContentView: View {
	@StateObject private var profileViewModel = ProfileViewModel(
		userService: UserService())
	@StateObject var networkManager = NetworkManager()

	// Создаем экземпляры сервисов
	private let tokenService: TokenServiceProtocol = TokenService()

	var body: some View {
		if profileViewModel.isLogin {
			NavigationStack {
				TabBarView()
					.environmentObject(profileViewModel)
					.environmentObject(networkManager)
			}
		} else {
			NavigationStack {
				SignUpView(
					signUpService: SignUpService()
				)
				.environmentObject(profileViewModel)
				.environmentObject(networkManager)
			}
		}
	}
}

#Preview {
	ContentView()
}
