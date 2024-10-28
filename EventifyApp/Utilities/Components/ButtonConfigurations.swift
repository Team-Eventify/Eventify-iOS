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
    case registration
    case addEvent
    case saving
    case cancel
    
    var title: String {
        switch self {
        case .commom:
            return NSLocalizedString("button_next", comment: "Далее")
        case .signUp:
            return NSLocalizedString("button_sign_up", comment: "Зарегистрироваться")
        case .signIn:
            return NSLocalizedString("login_title", comment: "Войти")
        case .forgotPassword:
            return NSLocalizedString("button_send", comment: "Отправить")
        case .registration:
            return NSLocalizedString("button_register_for_event", comment: "Записаться на ивент")
        case .addEvent:
            return NSLocalizedString("button_publish_event", comment: "Опубликовать ивент")
        case .saving:
            return NSLocalizedString("button_save_changes", comment: "Сохранить изменения")
        case .cancel:
            return NSLocalizedString("button_cancel_registration", comment: "Отменить запись на ивент")
        }
    }
    
    var color: Color {
        switch self {
        case .commom, .signUp, .signIn, .forgotPassword, .registration, .addEvent, .saving:
            return .brandCyan
        case .cancel:
            return .error
        }
    }
}
