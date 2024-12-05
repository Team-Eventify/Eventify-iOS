//
//  CategoriesEndpoints.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.12.2024.
//

import Foundation
import Moya

extension API.CategoriesEndpoints: TargetType, AccessTokenAuthorizable {
	var baseURL: URL {
		return URL(string: API.baseURL)!
	}
	
	var path: String {
		switch self {
		case .getCategories:
			return "category"
		case .getUserCategories(let id):
			return "users/\(id)/categories"
		case .setUserCategories(let id, _):
			return "users/\(id)/categories"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getCategories, .getUserCategories:
			return .get
		case .setUserCategories:
			return .put
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .getCategories, .getUserCategories:
				.requestPlain
		case .setUserCategories(_, let categoriesIds):
				.requestCustomJSONEncodable(categoriesIds, encoder: JSONEncoder())
		}
	}

	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var authorizationType: Moya.AuthorizationType? {
		switch self {
		case .getCategories, .getUserCategories, .setUserCategories:
			return .bearer
		}
	}
}
