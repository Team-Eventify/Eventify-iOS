//
//  EventsService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.09.2024.
//

import Foundation

protocol EventsServiceProtocol {
    func newEvent(json: JSON) async throws -> EventsResponse
}

final class EventsService: Request, EventsServiceProtocol {
    func newEvent(json: JSON) async throws -> EventsResponse {
        return try await sendRequest(endpoint: EventsEndpoint.newEvent(json: json), responseModel: EventsResponse.self)
    }
}


struct EventsResponse: Decodable {
    let id, state, title, description: String
    let start, end: Int
    let location: Location
    let capacity: Int
    let categories: CategoriesArray?
    let ownerID: String
    let price: Price
    let subscribers: Subscribers?
    let moderated: Bool
    let subscriber: Subscriber?
    let CreatedAt, ModifiedAt: Int
}

struct Location: Decodable {
    let id, title, description: String
    let address: Address
    let capacity: Int
}

struct Address: Decodable {
    let country, state, city, street, building: String
    let postalCode, lat, lon: Int
}

struct Price: Decodable {
    let amount: Int
    let currecny: String
}

struct Categories: Decodable {
    let id: String
    let title: String
}

struct Subscriber: Decodable {
    let userID: String
}

typealias Subscribers = [Subscriber]

typealias CategoriesArray = [Categories]
