//
//  API.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

/// Enum `API` c enpoint's
enum API {
	/// Базовый URL для API
	static let baseURL: String = "https://eventify.website/api/v1/"

	/// endpoint'ы для авторизации
	enum Authorization {
		static let register = "auth/register"
		static let login = "auth/login"
        static let refresh = "auth"
	}
    
    /// endpoint's для юзеров
    enum Users {
        static let getUser = "users"
    }
    
    /// endpoint's для категорий
    enum Categories {
        static let getCategories = "category"
    }
    
    enum Events {
        static let newEvent = "events"
    }
}
