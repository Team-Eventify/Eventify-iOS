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
    case listEvents
    
    var path: String {
        switch self {
        case .newEvent:
            return API.Events.newEvent
        case .listEvents:
            return API.Events.newEvent
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .newEvent:
            return .post
        case .listEvents:
            return .get
        }
    }
    
    var header: [String: String]? { return nil }
    
    var addAuthorizationToken: Bool { return true } 
    
    var parameters: JSON? {
        switch self {
        case .newEvent(let json):
            return json
        case .listEvents:
            return nil
        }
    }
}
