//
//  CheepsStyle.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

enum CheepsStyle {
    case registation
    case upcoming
    case common
    case past

    var titleColor: Color {
        switch self {
        case .registation: return .black
        case .upcoming: return .cheeps
        case .common: return .mainText
        case .past: return .cheeps
        }
    }

    var backgroundColor: Color {
        switch self {
        case .registation: return .brandCyan
        case .upcoming: return .mainText
		case .common: return .mainText
        case .past: return .cheepsGray
        }
    }
}
