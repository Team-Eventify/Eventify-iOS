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

    var titleColor: Color {
        switch self {
        case .registation: return .black
        case .upcoming: return .cheeps
        case .common: return .mainText
        }
    }

    var backgroundColor: Color {
        switch self {
        case .registation: return .brandCyan
        case .upcoming: return .mainText
        case .common: return .clear
        }
    }

    var shape: any Shape {
        switch self {
        case .registation: return Capsule()
        case .upcoming: return Rectangle()
        case .common: return Rectangle()
        }
    }
}
