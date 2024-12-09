//
//  RequestEncoder.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Декодировщик запроса
class RequestEncoder {
	static func json(parameters: [String: Any]) -> Data? {
		do {
			return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
		} catch {
			Logger.log(level: .error(error), "")
			return nil
		}
	}
}
