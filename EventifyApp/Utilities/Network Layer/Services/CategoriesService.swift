//
//  CategoriesService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 24.09.2024.
//

import Foundation

protocol CategoriesServiceProtocol {
    func getCategories() async throws -> CategoriesResponseModel
}

final class CategoriesService: Request, CategoriesServiceProtocol {
    func getCategories() async throws -> CategoriesResponseModel {
        return try await sendRequest(endpoint: CategoriesEndpoint.getCategories, responseModel: CategoriesResponseModel.self)
    }
}

struct CategoriesResponse: Decodable {
    let id: String
    let title: String
}

typealias CategoriesResponseModel = [CategoriesResponse]
