//
//  CategoriesEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 24.09.2024.
//

import Foundation

enum CategoriesEndpoint: Endpoint {
    case getCategories
    
    var path: String {
        switch self {
        case .getCategories:
            return API.Categories.getCategories
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getCategories:
                return .get
        }
    }
    
    var header: [String : String]? { return nil }
    
    var parameters: JSON? { return nil }
}
