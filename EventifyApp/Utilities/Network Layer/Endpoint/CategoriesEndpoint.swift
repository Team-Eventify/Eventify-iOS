//
//  CategoriesEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 24.09.2024.
//

import Foundation

enum CategoriesEndpoint: Endpoint {
    case getCategories
    case getUserCategories(id: String)
    case setUserCategories(id: String, categoriesIds: [String])

    var path: String {
        switch self {
        case .getCategories:
            return API.Categories.getCategories
        case .getUserCategories(let id):
            return API.Users.getUser + "/\(id)/categories"
        case .setUserCategories(let id, _):
            return API.Users.getUser + "/\(id)/categories"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getCategories:
            return .get
        case .getUserCategories:
            return .get
        case .setUserCategories:
            return .put
        }
    }

    var header: [String: String]? { return nil }
    
    var addAuthorizationToken: Bool { return true }

    var parameters: JSON? {
        switch self {
        case .getCategories:
            return nil
        case .getUserCategories:
            return nil
        case .setUserCategories(_, let categoriesIds):
            return ["categories": categoriesIds]
        }
    }
}
