//
//  ProfileViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.07.2024.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
	// MARK: - Public Properties
	@Published var name: String = ""
	@Published var middleName: String = ""
	@Published var showingDeleteAlert: Bool = false
	@Published var showingExitAlert: Bool = false
	@Published var navigateToSignUp: Bool = false

	private let userService: UsersServiceProtocol

	init(userService: UsersServiceProtocol) {
		self.userService = userService
	}

	func updateUserInfo() {
		Task { @MainActor in
			if isFioNotEmpty() {
				name =
					UserDefaultsManager.shared.getFirstName()
					?? String(localized: "your_name_profile")
				middleName = UserDefaultsManager.shared.getMiddleName() ?? ""
			} else {
				do {
					let userid =
						KeychainManager.shared.get(key: KeychainKeys.userId)
						?? ""
					let userResponse = try await userService.getUser(id: userid)

					name = userResponse.firstName
					middleName = userResponse.middleName

					if !userResponse.firstName.isEmpty
						&& !userResponse.middleName.isEmpty {
						UserDefaultsManager.shared.setFirstName(
							userResponse.firstName)
						UserDefaultsManager.shared.setMiddleName(
							userResponse.middleName)
					}
				} catch {
					Logger.log(level: .error(error), "User info error:")
					name = String(localized: "your_name_profile")
					middleName = ""
				}
			}
		}
	}

	@MainActor
	private func isFioNotEmpty() -> Bool {
		guard let firstName = UserDefaultsManager.shared.getFirstName(),
			let middleName = UserDefaultsManager.shared.getMiddleName()
		else {
			return false
		}
		return !firstName.isEmpty && !middleName.isEmpty
	}
}
