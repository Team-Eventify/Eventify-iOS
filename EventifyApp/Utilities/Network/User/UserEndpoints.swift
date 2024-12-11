//
//  UserEndpoints.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.12.2024.
//

import Foundation
import Moya

extension API.UserEndpoints: TargetType, AccessTokenAuthorizable {
	var baseURL: URL {
		return URL(string: API.baseURL)!
	}
	
	var path: String {
		switch self {
		case .getUserInfo(let id), .patchUserInfo(let id, _):
			return "users/\(id)"
		case .subscribedEvents(let id):
			return "users/\(id)/events"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getUserInfo, .subscribedEvents:
			return .get
		case .patchUserInfo:
			return .patch
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .patchUserInfo(_, let request):
				.requestJSONEncodable(request)
		default:
				.requestPlain
		}
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var authorizationType: AuthorizationType? {
		switch self {
		case .getUserInfo, .patchUserInfo, .subscribedEvents:
			return .bearer
		}
	}
}
