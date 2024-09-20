//
//  TokenEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.09.2024.
//

import Foundation

enum TokenEndpoint: Endpoint {
    case refresh(refreshToken: String)

    var path: String {
        switch self {
        case .refresh:
            return API.Authorization.refresh
        }
    }

    var method: RequestMethod {
        switch self {
        case .refresh:
            return .post
        }
    }

    var header: [String: String]? { return nil }

    var parameters: JSON? {
        switch self {
        case .refresh(let refreshToken):
            return ["refresh": refreshToken]
        }
    }
}
