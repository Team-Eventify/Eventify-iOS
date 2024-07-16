//
//  Endpoint.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Foundation

typealias JSON = [String: Any]

protocol Endpoint {
	var path: String { get }
	var method: RequestMethod { get }
	var header: [String: String]? { get }
	var parameters: [String: Any]? { get }
}
