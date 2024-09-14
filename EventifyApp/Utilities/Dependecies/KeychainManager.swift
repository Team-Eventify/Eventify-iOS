//
//  KeychainManager.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.09.2024.
//

import SwiftUI
import KeychainSwift

final class KeychainManager {
	static let shared = KeychainManager()

	let keychain: KeychainSwift

	private init() {
		let keychain = KeychainSwift()
		keychain.synchronizable = true
		self.keychain = keychain
	}

	func set(_ value: String, key: String) {
		keychain.set(value, forKey: key)
	}

	func get(key: String) -> String? {
		keychain.get(key)
	}
}
