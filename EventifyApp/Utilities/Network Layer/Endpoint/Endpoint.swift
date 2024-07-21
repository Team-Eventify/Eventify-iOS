//
//  Endpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

typealias JSON = [String: Any]

/// Конечная точка запроса
protocol Endpoint {
	/// путь к конечной точке
	var path: String { get }

	/// метод запроса
	var method: RequestMethod { get }

	/// заголовок запроса
	var header: [String: String]? { get }

	/// параметры запроса
	var parameters: [String: Any]? { get }
}
