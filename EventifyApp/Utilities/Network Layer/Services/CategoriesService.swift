//
//  CategoriesService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 24.09.2024.
//

import Foundation

protocol CategoriesServiceProtocol {
    func getCategories() async throws -> CategoriesResponseModel
    func getUserCategories(id: String) async throws -> CategoriesResponseModel
    func setUserCategories(id: String, categoriesIds: [String]) async throws -> SetUserCategoriesModel
}

final class CategoriesService: Request, CategoriesServiceProtocol {
    func getCategories() async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.getCategories, responseModel: CategoriesResponseModel.self)
    }
    
    func getUserCategories(id: String) async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.getUserCategories(id: id), responseModel: CategoriesResponseModel.self)
    }
    
    func setUserCategories(id: String, categoriesIds: [String]) async throws -> SetUserCategoriesModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.setUserCategories(id: id, categoriesIds: categoriesIds ), responseModel: SetUserCategoriesModel.self)
    }
}

struct CategoriesResponse: Decodable {
    let id, title: String
}

typealias CategoriesResponseModel = [CategoriesResponse]

struct SetUserCategoriesModel: Decodable {}
