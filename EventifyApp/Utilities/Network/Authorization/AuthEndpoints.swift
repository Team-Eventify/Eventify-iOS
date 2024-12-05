//
//  AuthEndpoints.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//

import Foundation
import Moya

extension API.AuthEndpoints: TargetType {
	var baseURL: URL {
		return URL(string: API.baseURL)!
	}
	
	var path: String {
		switch self {
		case .signUp:
			return "auth/register"
		case .signIn:
			return "auth/login"
		case .refresh:
			return "auth"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .signUp, .signIn, .refresh:
			return .post
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .signUp(let request):
			return .requestJSONEncodable(request)
		case .signIn(let request):
			return .requestJSONEncodable(request)
		case .refresh(let request):
			return .requestJSONEncodable(request)
		}
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
}
