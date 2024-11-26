//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var profileViewModel = ProfileViewModel(
		userService: UserService())
	@StateObject var networkManager = NetworkManager()
	
	@StateObject private var appCoordinator = AppCoordinator(path: .init())

	private let tokenService: TokenServiceProtocol = TokenService()

	var body: some View {
		appCoordinator.build()
	}
}

#Preview {
	ContentView()
}
