//
//  ValidationRule.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 01.10.2024.
//

import SwiftUI

struct ValidationRule: Identifiable {
    let id = UUID()
    let description: String
    var isValid: Bool
    let correctIcon: Image
}
