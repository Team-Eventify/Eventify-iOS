//
//  ProfileSectionItem.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.11.2024.
//

import SwiftUI

enum ProfileSectionItem: Identifiable {
	case addEvent
	case notifications
	case helpAndSupport
	case aboutApp
	case rateApp
	case logout
	case deleteAccount

	var id: String { titleKey }

	var titleKey: String {
		switch self {
		case .addEvent:
			"action_add_event"
		case .notifications:
			"section_notifications"
		case .helpAndSupport:
			"section_help_support"
		case .aboutApp:
			"section_about_app"
		case .rateApp:
			"action_rate_app"
		case .logout:
			"action_logout"
		case .deleteAccount:
			"action_delete_account"
		}
	}

	var destination: AppCoordinator.Destination {
		switch self {
		case .addEvent:
			return .addEvent
		case .notifications:
			return .notifications
		case .helpAndSupport, .aboutApp:
			return .empty
		case .rateApp:
			return .feedback
		default:
			return .empty
		}
	}

	var isDestructive: Bool {
		self == .logout || self == .deleteAccount
	}

	var alertTitleKey: String? {
		switch self {
		case .logout:
			"alert_logout_confirmation"
		case .deleteAccount:
			"alert_delete_account_confirmation"
		default: nil
		}
	}
}
