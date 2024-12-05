//
//  AuthorizationPlugin.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//

import Foundation

import Foundation
import Moya

class AuthorizationPlugin: PluginType {
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		var request = request
		if let token = KeychainManager.shared.get(key: KeychainKeys.accessToken) {
			request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		return request
	}
}
