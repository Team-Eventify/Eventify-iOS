//
//  EventsEndpoints.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//

import Foundation
import Moya

extension API.EventEndpoints: TargetType, AccessTokenAuthorizable {
	var baseURL: URL {
		return URL(string: API.baseURL)!
	}

	var path: String {
		switch self {
		case .newEvent:
			return "events"
		case .listEvents:
			return "events"
		case .subscribe(let eventId):
			return "events/\(eventId)/subscribers"
		}
	}

	var method: Moya.Method {
		switch self {
		case .newEvent, .subscribe:
			return .post
		case .listEvents:
			return .get
		}
	}

	var task: Moya.Task {
		switch self {
		case .newEvent(let request):
			return .requestJSONEncodable(request)
		default:
			return .requestPlain
		}
	}

	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}

	var authorizationType: Moya.AuthorizationType? {
		switch self {
		case .newEvent, .listEvents, .subscribe:
			return .bearer
		}
	}
}
