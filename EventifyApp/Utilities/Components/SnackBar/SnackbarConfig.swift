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
				return "Вы успешно записались\nна мероприятие!"
			case .failure:
				return "Ошибка авторизации!\nПроверьте логин или пароль."
			case .recovery:
				return "Письмо для сброса пароля\nуспешно отправлено на почту."
            case .failureOfAddingEvent:
                return "Ошибка добавления мероприятия!"
		}
	}

	var icon: String {
		switch self {
			case .registration:
				return "successIcon"
			case .failure:
				return "failureIcon"
			case .recovery:
				return "successIcon"
            case .failureOfAddingEvent:
                return "failureIcon"
		}
	}
}
