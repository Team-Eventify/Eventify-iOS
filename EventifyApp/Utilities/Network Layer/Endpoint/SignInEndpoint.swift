//
//  SignInEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Конечная точка для запроса входа
enum SignInEndpoint: Endpoint {
	case signIn(json: JSON)

	var path: String {
		switch self {
			case .signIn:
				return API.Authorization.login
		}
	}

	var method: RequestMethod {
		switch self {
			case .signIn:
				return .post
		}
	}

	var header: [String: String]? { return nil }
    
    var addAuthorizationToken: Bool { return false }

	var parameters: JSON? {
		switch self {
			case .signIn(let json):
				return json
		}
	}
}
