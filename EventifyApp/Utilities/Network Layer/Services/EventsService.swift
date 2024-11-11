//
//  EventsService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.09.2024.
//

import Foundation

protocol EventsServiceProtocol {
    
    /// Создание мероприятия
    /// - Parameter json: json-данные нового мероприятия
    /// - Returns: модель ответа мероприятия
    func newEvent(json: JSON) async throws -> NewEventResponse
    
    /// Получение списка мероприятий
    /// - Returns: Массив ивентов
    func listEvents() async throws -> EventsListResponse
}

final class EventsService: Request, EventsServiceProtocol {
    func newEvent(json: JSON) async throws -> NewEventResponse {
        return try await sendRequest(endpoint: EventsEndpoint.newEvent(json: json), responseModel: NewEventResponse.self)
    }
    
    func listEvents() async throws -> EventsListResponse {
        return try await sendRequest(endpoint: EventsEndpoint.listEvents, responseModel: EventsListResponse.self)
    }
}

struct NewEventResponse: Decodable {
	let id, state, title, description: String
	let start, end: Int
	let capacity: Int
	let ownerID: String
	let moderated: Bool
	let CreatedAt, ModifiedAt: Int
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

struct Categories: Decodable, Identifiable, Hashable {
    let id: String
    let title: String
}

struct Subscriber: Decodable {
    let userID: String
}

typealias Subscribers = [Subscriber]

typealias CategoriesArray = [Categories]


// MARK: - EventsListResponseElement
struct EventsListResponseElement: Codable {
    let id, state, title, description: String
    let start, end, capacity: Int
    let ownerID: String
    let moderated: Bool
    let createdAt, modifiedAt: Int

    enum CodingKeys: String, CodingKey {
        case id, state, title, description, start, end, capacity, ownerID, moderated
        case createdAt = "CreatedAt"
        case modifiedAt = "ModifiedAt"
    }
}

typealias EventsListResponse = [EventsListResponseElement]
