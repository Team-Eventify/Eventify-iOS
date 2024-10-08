//
//  RequestError.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//
import Foundation

/// Ошибки запросов
enum RequestError: Error, LocalizedError {
	/// Неверный url
	case invalidURL

	/// Нет ответа
	case noResponse

	/// Не может декодировать
	case decode

	/// Неизвестный статус код
	case unexpectedStatusCode
    
    /// Ошибка авторизации
    case authentinticationFailed
    
    /// Ошибка обновления токена
    case tokenRefreshFailed
    
    /// Ошибка сохранения токена
    case tokenSaveFailed
    
    /// Достигнуто максимальное количество попыток обновления токена
    case maxTokenRefreshAttemptsReached
    
	/// Неизвестная ошибка
	case unknown

	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "The URL provided was invalid."
		case .noResponse:
			return "No response from the server."
		case .decode:
			return "Failed to decode the response."
		case .unexpectedStatusCode:
			return "Unexpected status code received from the server."
        case .authentinticationFailed:
            return "Authentication failed."
        case .tokenRefreshFailed:
            return "Token refresh failed."
        case .tokenSaveFailed:
            return "Token save failed."
        case .maxTokenRefreshAttemptsReached:
            return "Max token refresh attempts reached."
		case .unknown:
			return "An unknown error occurred."
		}
	}
}
