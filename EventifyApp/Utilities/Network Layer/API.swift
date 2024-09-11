//
//  API.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

enum API {
	/// Базовый URL для API
	static let baseURL: String = "http://188.225.82.113:8090/api/v1/"

	/// endpoint'ы для авторизации
	enum Authorization {
		static let register = "auth/register"
		static let login = "auth/login"
	}
}
