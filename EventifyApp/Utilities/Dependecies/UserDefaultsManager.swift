//
//  UserDefaultsManager.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.09.2024.
//

import Foundation

final class UserDefaultsManager {
    /// Синглтон менеджера
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    // MARK: - First Name
    
    func setFirstName(_ firstName: String) {
        defaults.set(firstName, forKey: UserDefaultsKeys.firstName.rawValue)
    }
    
    func getFirstName() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.firstName.rawValue)
    }
    
    func removeFirstName() {
        defaults.removeObject(forKey: UserDefaultsKeys.firstName.rawValue)
    }
    
    // MARK: - Middle Name
    
    func setMiddleName(_ middleName: String) {
        defaults.set(middleName, forKey: UserDefaultsKeys.middleName.rawValue)
    }
    
    func getMiddleName() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.middleName.rawValue)
    }
    
    func removeMiddleName() {
        defaults.removeObject(forKey: UserDefaultsKeys.middleName.rawValue)
    }
    
    // MARK: - Last Name
    
    func setLastName(_ lastName: String) {
        defaults.set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    func getLastName() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    func removeLastName() {
        defaults.removeObject(forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    // MARK: - Telegram
    
    func setTelegram(_ telegram: String) {
        defaults.set(telegram, forKey: UserDefaultsKeys.telegramName.rawValue)
    }
    
    func getTelegram() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.telegramName.rawValue)
    }
    
    func removeTelegram() {
        defaults.removeObject(forKey: UserDefaultsKeys.telegramName.rawValue)
    }
    
    // MARK: - Общие методы
    
    func clearAllUserData() {
        UserDefaultsKeys.allCases.forEach { defaults.removeObject(forKey: $0.rawValue) }
    }
}
