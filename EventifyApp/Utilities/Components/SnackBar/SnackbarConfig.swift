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
                return NSLocalizedString("snackbar_registration_success", comment: "Вы успешно записались на мероприятие!")
            case .failure:
                return NSLocalizedString("snackbar_auth_failure", comment: "Ошибка авторизации! Проверьте логин или пароль.")
            case .recovery:
                return NSLocalizedString("snackbar_password_recovery_success", comment: "Письмо для сброса пароля успешно отправлено на почту.")
            case .failureOfAddingEvent:
                return NSLocalizedString("snackbar_event_add_failure", comment: "Ошибка добавления мероприятия!")
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
