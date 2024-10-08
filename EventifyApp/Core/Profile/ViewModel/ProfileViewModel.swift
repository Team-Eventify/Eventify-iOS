//
//  ProfileViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.07.2024.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    // MARK: - Public Properties

    @AppStorage("isLogin") var isLogin: Bool = false
    @Published var name: String = ""
    @Published var surname: String = ""

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func updateUserInfo() {
        Task { @MainActor in
            if isFioNotEmpty() {
                name = UserDefaultsManager.shared.getFirstName() ?? "Имя"
                surname = UserDefaultsManager.shared.getLastName() ?? "Фамилия"
                Log.info("User fio is already set 🙋‍♂️")
            } else {
                do {
                    let userid = KeychainManager.shared.get(key: KeychainKeys.userId) ?? ""
                    let userResponse = try await userService.getUser(id: userid)
                    
                    name = userResponse.firstName
                    surname = userResponse.lastName
                    
                    if !userResponse.firstName.isEmpty && !userResponse.lastName.isEmpty {
                        UserDefaultsManager.shared.setFirstName(userResponse.firstName)
                        UserDefaultsManager.shared.setLastName(userResponse.lastName)
                    }
                } catch {
                    Log.error("User info error:", error: error)
                    name = "Имя"
                    surname = "Фамилия"
                }
            }
        }
    }

    private func isFioNotEmpty() -> Bool {
        guard let firstName = UserDefaultsManager.shared.getFirstName(),
              let lastName = UserDefaultsManager.shared.getLastName() else {
            return false
        }
        return !firstName.isEmpty && !lastName.isEmpty
    }
}
