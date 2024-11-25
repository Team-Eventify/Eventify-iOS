//
//  ProfileMenuSection.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.11.2024.
//

import Foundation

enum ProfileMenuSection: Int, Identifiable, CaseIterable {
	case main
	case options
	case about
	case account

	var id: Int { rawValue }
	var items: [ProfileSectionItem] {
		switch self {
		case .main:
			return [.addEvent]
		case .options:
			return [.notifications, .helpAndSupport]
		case .about:
			return [.aboutApp, .rateApp]
		case .account:
			return [.logout, .deleteAccount]
		}
	}
}
