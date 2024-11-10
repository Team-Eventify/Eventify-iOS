//
//  KeychainManager.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.09.2024.
//

import SwiftUI

final class KeychainManager {
    static let shared = KeychainManager()

    private init() {}

	@discardableResult
    func set(_ value: String, key: String) -> Bool {
        let data = value.data(using: .utf8)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data as Any,
        ]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let data = dataTypeRef as? Data,
                let result = String(data: data, encoding: .utf8)
            {
                return result
            }
        }

        return nil
    }

    @discardableResult
    func clearAll() -> Bool {
        let secItemClasses = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity,
        ]

        var success = true

        for secItemClass in secItemClasses {
            let query: [String: Any] = [kSecClass as String: secItemClass]
            let status = SecItemDelete(query as CFDictionary)

            if status != errSecSuccess && status != errSecItemNotFound {
                print("Ошибка при очистке Keychain для класса \(secItemClass): \(status)")
                success = false
            }
        }

        return success
    }

    func setTokenCreationTime(_ date: Date) {
        UserDefaults.standard.set(date.timeIntervalSince1970, forKey: "tokenCreationTime")
    }

    func getTokenCreationTime() -> Date? {
        let timeInterval = UserDefaults.standard.double(forKey: "tokenCreationTime")
        return timeInterval > 0
            ? Date(timeIntervalSince1970: timeInterval) : nil
    }
}
