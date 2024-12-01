//
//  ProfileDetailViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.07.2024.
//

import SwiftUI

/// Вью модель детального экрана профиля
@MainActor
final class ProfileDetailViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var name: String = ""
	@Published var surname: String = ""
	@Published var lastName: String? = ""
	@Published var email: String = ""
	@Published var telegram: String = ""
	@Published var isLoading: Bool = false
	@Published var shouldDismiss: Bool = false

	private let userService: UserServiceProtocol

	init(userService: UserServiceProtocol) {
		self.userService = userService
		loadFromUserDefaults()
	}

	let userID = KeychainManager.shared.get(
		key: KeychainKeys.userId
	)

	// MARK: - Private Methods

	private func loadFromUserDefaults() {
		name = UserDefaultsManager.shared.getFirstName() ?? ""
		surname = UserDefaultsManager.shared.getMiddleName() ?? ""
		lastName = UserDefaultsManager.shared.getLastName() ?? ""
		email = KeychainManager.shared.get(key: KeychainKeys.userEmail) ?? ""
		telegram = UserDefaultsManager.shared.getTelegram() ?? ""
	}

	private func saveToUserDefaults() {
		UserDefaultsManager.shared.setFirstName(name)
		UserDefaultsManager.shared.setMiddleName(surname)
		UserDefaultsManager.shared.setLastName(lastName ?? "")
		UserDefaultsManager.shared.setTelegram(telegram)
	}

	private func areAllFieldsFilled() -> Bool {
		return !name.isEmpty && !surname.isEmpty && !email.isEmpty
			&& !telegram.isEmpty
	}

	/// Получение данных пользователя
	func getUser() {
		Task { @MainActor in
			do {
				let response = try await userService.getUser(id: userID ?? "")
				name = response.firstName
				surname = response.middleName
				lastName = response.lastName
				email =
					KeychainManager.shared.get(key: KeychainKeys.userEmail)
					?? ""
				telegram = response.telegramName

				saveToUserDefaults()
			}
		}
	}

	/// Обновление данных пользователя
	func patchUser() {
		guard !name.isEmpty, !surname.isEmpty, !telegram.isEmpty else {
			return
		}
		isLoading = true
		let json: JSON = [
			"firstName": name, "middleName": surname,
			"lastName": lastName ?? "", "telegramName": telegram,
		]

		Task { @MainActor in
			do {
				let _ = try await userService.patchUser(
					id: userID ?? "No key", json: json)
				shouldDismiss = true
				saveToUserDefaults()
			} catch {
				isLoading = false
				Logger.log(level: .error(error), "")
			}
		}
	}
}
