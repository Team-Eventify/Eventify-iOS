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
    @Published var middleName: String = ""

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func updateUserInfo() {
        Task { @MainActor in
            if isFioNotEmpty() {
                name = UserDefaultsManager.shared.getFirstName() ?? "Имя"
                middleName = UserDefaultsManager.shared.getMiddleName() ?? "Фамилия"
                Log.info("User fio is already set 🙋‍♂️")
            } else {
                do {
                    let userid = KeychainManager.shared.get(key: KeychainKeys.userId) ?? ""
                    let userResponse = try await userService.getUser(id: userid)
                    
                    name = userResponse.firstName
                    middleName = userResponse.middleName
                    
                    if !userResponse.firstName.isEmpty && !userResponse.middleName.isEmpty {
                        UserDefaultsManager.shared.setFirstName(userResponse.firstName)
                        UserDefaultsManager.shared.setMiddleName(userResponse.middleName)
                    }
                } catch {
                    Log.error("User info error:", error: error)
                    name = "Имя"
                    middleName = "Фамилия"
                }
            }
        }
    }

    private func isFioNotEmpty() -> Bool {
        guard let firstName = UserDefaultsManager.shared.getFirstName(),
              let middleName = UserDefaultsManager.shared.getMiddleName() else {
            return false
        }
        return !firstName.isEmpty && !middleName.isEmpty
    }
}
