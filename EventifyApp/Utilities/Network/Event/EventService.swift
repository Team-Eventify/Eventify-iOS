//
//  EventService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.12.2024.
//
//

import Foundation
import Moya

protocol EventServiceProtocol {
	func newEvent(request: NewEventRequest) async throws
	func listEvents() async throws -> EventsListResponse
	func subscribeForEvent(eventId: String) async throws
}

final class EventService: EventServiceProtocol {
	private let tokenService = TokenService()
	private let provider: MoyaProvider<API.EventEndpoints>
	
	init() {
		let refreshablePlugin = RefreshablePlugin()
		self.provider = MoyaProvider<API.EventEndpoints>(
			plugins: [
				NetworkLoggerPlugin(),
				AccessTokenPlugin(tokenClosure: { _ in
					let token = KeychainManager.shared.get(key: KeychainKeys.accessToken) ?? ""
					Logger.log(level: .network, "AccessTokenPlugin: Using token: \(token)")
					return token
				}),
				refreshablePlugin
			]
		)
	}

	func newEvent(request: NewEventRequest) async throws {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.newEvent(request: request)) { result in
				switch result {
				case .success(let response):
						continuation.resume()
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func listEvents() async throws -> EventsListResponse {
		return try await withCheckedThrowingContinuation { continuation in
			provider.request(.listEvents) { result in
				switch result {
				case .success(let response):
					do {
						let eventListResponse = try response.map(EventsListResponse.self)
						continuation.resume(returning: eventListResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func subscribeForEvent(eventId: String) async throws {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.subscribe(eventId: eventId)) { result in
				switch result {
				case .success(let response):
					continuation.resume()
				case .failure(let error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
}

// Структуры данных

struct NewEventRequest: Encodable {
	let title: String
	let description: String
	let start: Int
	let end: Int
	let ownerID: String
}

struct EventsListResponseElement: Codable {
	let id, state, title, description: String
	let start, end, capacity: Int
	let ownerID: String
	let moderated: Bool
}

typealias EventsListResponse = [EventsListResponseElement]

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
