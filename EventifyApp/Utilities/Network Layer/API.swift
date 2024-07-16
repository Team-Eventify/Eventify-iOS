//
//  API.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

enum API {
	static let baseURL: String = "http://185.128.107.9:8080/api/"

	enum Authorization {
		static let register = "user/register"
		static let login = "user/login"
		static let logOut = "user/logout"
	}
}
