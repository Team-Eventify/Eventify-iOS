//
//  CategoryService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.12.2024.
//

import Foundation
import Moya

protocol CategoryServiceProtocol {
	func getCategories() async throws -> CategoriesResponseModel
	func getUserCategories(id: String) async throws -> CategoriesResponseModel
	func setUserCategories(id: String, categoriesIds: [String]) async throws
}

final class CategoryService: CategoryServiceProtocol {
	private let tokenService = TokenService()
	private let provider: MoyaProvider<API.CategoriesEndpoints>
	
	init() {
		let refreshablePlugin = RefreshablePlugin()
		self.provider = MoyaProvider<API.CategoriesEndpoints>(
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
	
	func getCategories() async throws -> CategoriesResponseModel {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.getCategories) { result in
				switch result {
				case .success(let response):
					do {
						let categories = try  response.map(CategoriesResponseModel.self)
						continuation.resume(returning: categories)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func getUserCategories(id: String) async throws -> CategoriesResponseModel {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.getUserCategories(id: id)) { result in
				switch result {
				case .success(let response):
					do {
						let userCategories = try response.map(CategoriesResponseModel.self)
						continuation.resume(returning: userCategories)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func setUserCategories(id: String, categoriesIds: [String]) async throws {
		try await withCheckedThrowingContinuation { continuation in
			provider.request(.setUserCategories(id: id, categoriesIds: categoriesIds)) { result in
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

struct CategoriesResponse: Decodable {
	let id, title: String
}

typealias CategoriesResponseModel = [CategoriesResponse]

struct SetUserCategoriesModel: Decodable {}
