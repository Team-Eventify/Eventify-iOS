//
//  APIServic.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 02.12.2024.
//

import Foundation
import Moya

enum API {
	static let baseURL: String = "https://eventify.website/api/v1/"
	
	enum AuthEndpoints {
		case signUp(request: SignUpRequest)
		case signIn(request: SignInRequest)
		case refresh(request: RefreshRequest)
	}
	
	enum EventEndpoints {
		case newEvent(request: NewEventRequest)
		case listEvents
		case subscribe(eventId: String)
	}
	
	enum UserEndpoints {
		case getUserInfo(id: String)
		case patchUserInfo(id: String, request: PatchUserInfoRequest)
	}
	
	enum CategoriesEndpoints {
		case getCategories
		case getUserCategories(id: String)
		case setUserCategories(id: String, categoriesIds: [String])
	}
}

struct PatchUserInfoRequest: Encodable {
	let firstName: String
	let middleName: String
	let lastName: String
	let telegramName: String
}
