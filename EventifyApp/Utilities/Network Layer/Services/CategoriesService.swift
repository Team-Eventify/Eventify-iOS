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
    func setUserCategories(id: String, json: JSON) async throws -> CategoriesResponseModel
}

final class CategoriesService: Request, CategoriesServiceProtocol {
    func getCategories() async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.getCategories, responseModel: CategoriesResponseModel.self)
    }
    
    func getUserCategories(id: String) async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.getUserCategories(id: id), responseModel: CategoriesResponseModel.self)
    }
    
    func setUserCategories(id: String, json: JSON) async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.setUserCategories(id: id, json: json), responseModel: CategoriesResponseModel.self)
    }
}

struct CategoriesResponse: Decodable {
    let id, title: String
}

typealias CategoriesResponseModel = [CategoriesResponse]
