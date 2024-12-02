//
//  NetworkSession.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 02.12.2024.
//

import Foundation
import Combine

protocol NetworkSession: AnyObject {
	func publisher<T>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}

extension URLSession: NetworkSession {
	func publisher<T>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
		<#code#>
	}
}
