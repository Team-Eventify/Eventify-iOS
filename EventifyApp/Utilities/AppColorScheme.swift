//
//  AppColorSheme.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.07.2024.
//

import SwiftUI

enum Theme: String, CaseIterable {
	case light
	case dark
}

final class AppColorScheme: ObservableObject {
	static let shared = AppColorScheme()
	@Published var colorScheme: ColorScheme = .dark

	@AppStorage("selectedTheme") var selectedTheme: Theme = .dark {
		didSet {
			switch selectedTheme {
			case .light:
				colorScheme = .light
			case .dark:
				colorScheme = .dark
			}
		}
	}
}
