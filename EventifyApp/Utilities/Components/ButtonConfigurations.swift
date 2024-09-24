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
        case .commom: return "Далее"
        case .signUp: return "Зарегистрироваться"
        case .signIn: return "Войти"
        case .forgotPassword: return "Отправить"
        case .registration: return "Записаться на ивент"
        case .addEvent: return "Опубликовать ивент"
        case .saving: return "Сохранить изменения"
        case .cancel: return "Отменить запись на ивент"
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
