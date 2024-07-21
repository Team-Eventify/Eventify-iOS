//
//  SignUpEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Конечная точка для запроса регистрации
enum SignUpEndpoint: Endpoint {
	case signUp(json: JSON)

	var path: String {
		switch self {
			case .signUp:
				return API.Authorization.register
		}
	}

	var method: RequestMethod {
		switch self {
			case .signUp:
				return .post
		}
	}

	var header: [String: String]? { return nil }

	var parameters: JSON? {
		switch self {
			case .signUp(let json):
				return json
		}
	}
}
