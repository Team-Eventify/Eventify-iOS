//
//  Dictionary.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

extension Dictionary {
	func percentEncoded() -> Data? {
		return map { key, value in
			let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
			let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
			return "\(escapedKey)=\(escapedValue)"
		}
		.joined(separator: "&")
		.data(using: .utf8)
	}
}
