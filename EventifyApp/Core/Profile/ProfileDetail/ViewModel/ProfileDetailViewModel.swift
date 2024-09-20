//
//  ProfileDetailViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.07.2024.
//

import SwiftUI

/// Вью модель детального экрана профиля
final class ProfileDetailViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var telegram: String = ""

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    let userID = KeychainManager.shared.get(
        key: KeychainKeys.userId
    )

    /// Получение данных пользователя
    func getUser() {
        Task { @MainActor in
            do {
                let response = try await userService.getUser(id: userID ?? "")
                name = response.firstName
                surname = response.middleName
                lastName = response.lastName
                email = KeychainManager.shared.get(key: KeychainKeys.userEmail) ?? ""
                telegram = response.telegramName
            }
        }
    }
    
    func patchUser() {
        guard !name.isEmpty, !surname.isEmpty, !lastName.isEmpty, !telegram.isEmpty else {
            return
        }
        
        let json: JSON = ["firstName": name, "middleName": surname, "lastName": lastName, "telegramName": telegram]
        
        Task { @MainActor in
            do {
                let _ = try await userService.patchUser(id: userID ?? "No key", json: json)
                
                UserDefaultsManager.shared.setFirstName(name)
                UserDefaultsManager.shared.setMiddleName(surname)
                UserDefaultsManager.shared.setLastName(lastName)
                UserDefaultsManager.shared.setTelegram(telegram)
            }
        }
    }
}
