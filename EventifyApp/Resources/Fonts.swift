//
//  DesignSystem.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

enum Fonts {
    static let regular = "SFCompactRounded-Regular"
    static let medium = "SFCompactRounded-Medium"
    static let semibold = "SFCompactRounded-Semibold"
}

extension Font {
    static func regularCompact(size: CGFloat) -> Font {
        return Font.custom(Fonts.regular, size: size)
    }
    
    static func mediumCompact(size: CGFloat) -> Font {
        return Font.custom(Fonts.medium, size: size)
    }
    
    static func semiboldCompact(size: CGFloat) -> Font {
        return Font.custom(Fonts.semibold, size: size)
    }
}
