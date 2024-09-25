//
//  EventsEndpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.09.2024.
//

import Foundation

/// Endpoint's для ивентов
enum EventsEndpoint: Endpoint {
    case newEvent(json: JSON)
    
    var path: String {
        switch self {
        case .newEvent:
            return API.Events.newEvent
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .newEvent:
            return .post
        }
    }
    
    var header: [String : String]? { return nil }
    
    var parameters: [String : Any]? {
        switch self {
        case .newEvent(let json):
            return json
        }
    }
}
