//
//  AuthenticationProvider.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.11.2024.
//

import SwiftUI
import Combine

protocol AuthenticationProviderProtocol {
	var isAuthenticated: Bool { get set }
	
	func authenticate()
	func logout()
}

final class AuthenticationProvider: ObservableObject, AuthenticationProviderProtocol {
	@AppStorage("isLogin") var isLogin: Bool = false
	@Published var isAuthenticated: Bool = false

	private var subscriptions = Set<AnyCancellable>()

	init() {
		isAuthenticated = isLogin
		$isAuthenticated.dropFirst().sink { [weak self] isAuthenticated in
			self?.isLogin = isAuthenticated
		}
		.store(in: &subscriptions)
	}

	func authenticate() {
		isAuthenticated = true
		isLogin = true
	}

	func logout() {
		isAuthenticated = false
		isLogin = false
	}
}
