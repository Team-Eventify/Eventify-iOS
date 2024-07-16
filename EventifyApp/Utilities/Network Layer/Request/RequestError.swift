//
//  RequestError.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//
import Foundation

enum RequestError: Error, LocalizedError {
	case invalidURL
	case noResponse
	case decode
	case unexpectedStatusCode
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
