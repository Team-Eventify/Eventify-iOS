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
		case .unknown:
			return "An unknown error occurred."
		}
	}
}
