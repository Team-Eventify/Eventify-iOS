//
//  DomainConvertable.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 09.11.2024.
//

import Foundation

protocol DomainConvertable {
	associatedtype ConvertableType

	func asDomain() -> ConvertableType
}
