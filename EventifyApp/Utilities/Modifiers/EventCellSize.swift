//
//  EventCellSize.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.07.2024.
//

import Foundation

enum EventCellSize {
	case slim
	case large

	var width: CGFloat {
		switch self {
			case .slim: return 180
			case .large: return 235
		}
	}

	var height: CGFloat {
		switch self {
			case .slim: return 280
			case .large: return 278
		}
	}
}
