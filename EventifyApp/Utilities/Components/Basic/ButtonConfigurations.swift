//
//  ButtonConfigurations.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 24.09.2024.
//

import SwiftUI

/// Конфигурация кнопок
enum ButtonConfigurations {
	case commom
	case signUp
	case signIn
	case forgotPassword
	case sendRate
	case registration
	case addEvent
	case saving
	case cancel

	var title: String {
		switch self {
		case .commom:
			return String(localized: "button_next")
		case .signUp:
			return String(localized: "button_sign_up")
		case .signIn:
			return String(localized: "login_title")
		case .forgotPassword:
			return String(localized: "button_send")
		case .sendRate:
			return String(localized: "buttonSendRate")
		case .registration:
			return String(localized: "button_register_for_event")
		case .addEvent:
			return String(localized: "button_publish_event")
		case .saving:
			return String(localized: "button_save_changes")
		case .cancel:
			return String(localized: "button_cancel_registration")
		}
	}

	var color: Color {
		switch self {
		case .commom, .signUp, .signIn, .forgotPassword, .sendRate, .registration, .addEvent, .saving:
			return .brandCyan
		case .cancel:
			return .error
		}
	}
}
