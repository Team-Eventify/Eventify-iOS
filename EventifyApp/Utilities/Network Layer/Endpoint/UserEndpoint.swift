//
//  UserEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.09.2024.
//

import Foundation

/// Конечная точка для юзера
enum UserEndpoint: Endpoint {
    /// Получение информации пользователя
    /// - Parameter id: айди пользователя
    case getInfo(id: String)
    case patchInfo(id: String, json: JSON)
    
    var path: String {
        switch self {
        case .getInfo(id: let id), .patchInfo(let id, _):
            return API.Users.getUser + "/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getInfo:
            return .get
        case .patchInfo:
            return .patch
        }
    }
    
    var header: [String : String]? { return nil }
    
    var parameters: JSON? {
        switch self {
        case .getInfo:
            return nil
        case .patchInfo(_, let json):
            return json
        }
    }
}
