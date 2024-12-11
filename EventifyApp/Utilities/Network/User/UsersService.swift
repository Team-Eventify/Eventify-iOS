//
//  UsersService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.12.2024.
//

import Foundation
import Moya

protocol UsersServiceProtocol {
	func getUser(id: String) async throws -> UserResponse
	func patchUserInfo(id: String, request: PatchUserInfoRequest) async throws -> UserResponse
	func getSubscribedEvents(id: String) async throws -> EventsListResponse
}

final class UsersService: UsersServiceProtocol {
	private let tokenService = TokenService()
	private let provider: MoyaProvider<API.UserEndpoints>
	
	init() {
		let refreshablePlugin = RefreshablePlugin()
		self.provider = MoyaProvider<API.UserEndpoints>(
			handleRefreshToken: true,
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
	
	func getUser(id: String) async throws -> UserResponse {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.getUserInfo(id: id)) { result in
				switch result {
				case .success(let response):
					do {
						let getUserResponse = try response.map(UserResponse.self)
						continuation.resume(returning: getUserResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func patchUserInfo(id: String, request: PatchUserInfoRequest) async throws -> UserResponse {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.patchUserInfo(id: id, request: request)) { result in
				switch result {
				case .success(let response):
					do {
						let patchUserInfoResponse = try response.map(UserResponse.self)
						continuation.resume(returning: patchUserInfoResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func getSubscribedEvents(id: String) async throws -> EventsListResponse {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.subscribedEvents(id: id)) { result in
				switch result {
				case .success(let response):
					do {
						let eventsResponse = try response.map(EventsListResponse.self)
						continuation.resume(returning: eventsResponse)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}

/// Response модель пользователя
struct UserResponse: Decodable {
	let id: String
	let email: String
	let firstName: String
	let middleName: String
	let lastName: String?
	let telegramName: String
}
