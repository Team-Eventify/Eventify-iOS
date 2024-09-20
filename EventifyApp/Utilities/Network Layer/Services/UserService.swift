//
//  UserService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.09.2024.
//

import Foundation

protocol UserServiceProtocol {
    
    /// Получение данных пользователя
    /// - Parameter id: айди пользователя
    /// - Returns: модель ответа пользователя
    func getUser(id: String) async throws -> UserResponse
    
    
    /// Обновление данных пользователя
    /// - Parameters:
    ///   - id: айди пользователя
    ///   - data: данные для обновления
    /// - Returns: модель ответа пользователя
    func patchUser(id: String, json: JSON) async throws -> UserResponse
}

/// Сервис  пользователя (Экран профиля)
final class UserService: Request, UserServiceProtocol {
    func getUser(id: String) async throws -> UserResponse {
        return try await sendRequest(
            endpoint: UserEndpoint.getInfo(id: id),
            responseModel: UserResponse.self
        )
    }
    
    func patchUser(id: String, json: JSON) async throws -> UserResponse {
        return try await sendRequest(
            endpoint: UserEndpoint.patchInfo(
                id: id,
                json: json
            ),
            responseModel: UserResponse.self
        )
    }
    
}

/// Response модель пользователя
struct UserResponse: Decodable {
    let id: String
    let email: String
    let firstName: String
    let middleName: String
    let lastName: String
    let telegramName: String
}
