//
//  AppColorSheme.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.07.2024.
//

import SwiftUI

final class AppColorScheme: ObservableObject {
	static let shared = AppColorScheme()
	@Published var colorScheme: ColorScheme = .dark
}
