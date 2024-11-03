//
//  SnackbarConfig.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 09.09.2024.
//

import Foundation

enum SnackbarConfig {
	case registration
	case failure
	case recovery
    case failureOfAddingEvent

    var text: String {
        switch self {
            case .registration:
            return String(localized: "snackbar_registration_success")
            case .failure:
            return String(localized: "snackbar_auth_failure")
            case .recovery:
            return String(localized: "snackbar_password_recovery_success")
            case .failureOfAddingEvent:
            return String(localized: "snackbar_event_add_failure")
        }
    }

    var icon: String {
        switch self {
            case .registration, .recovery:
                return "successIcon"
            case .failure, .failureOfAddingEvent:
                return "failureIcon"
		}
	}
}
