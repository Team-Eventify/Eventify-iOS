//
//  EventifyTextField.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

struct EventifyTextField: View {
	@FocusState var isFocused: Bool
	@Binding var text: String
	let placeholder: String
	let isSecure: Bool
    let hasError: Bool
    
    private var borderColor: Color {
        if hasError {
            return Color.error
        } else if isFocused {
            return Color.mainText
        } else {
            return Color.gray
        }
    }
    
    /// Инициализатор `EventifyTextField`.
    ///
    /// Используется для создания текстового поля с возможностью отображения ошибки и конфигурации безопасности.
    ///
    /// - Parameters:
    ///   - text: Привязка (`Binding`) к строке, которая отображается и редактируется в текстовом поле.
    ///   - placeholder: Текст-заполнитель, отображаемый, когда поле пустое.
    ///   - isSecure: Логическое значение, определяющее, является ли поле безопасным (например, для ввода пароля).
    ///   - hasError: Логическое значение, определяющее, отображается ли красная рамка в случае ошибки. По умолчанию `false`.
    init(text: Binding<String>, placeholder: String, isSecure: Bool, hasError: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.hasError = hasError
    }

	var body: some View {
		Group {
			if isSecure {
				SecureField("", text: $text)
			} else {
				TextField("", text: $text)
			}
		}
		.autocorrectionDisabled()
		.autocapitalization(.none)
		.focused($isFocused)
		.frame(maxWidth: .infinity)
		.padding(.horizontal, 16)
		.padding(.vertical, 11)
		.setBorder(
			width: 1,
			color: borderColor,
			radius: 10
		)
		.overlay(placeholderTextContainerView)
		.font(.regularCompact(size: 17))
		.foregroundStyle(borderColor)
	}

	private var placeholderTextContainerView: some View {
		HStack(spacing: .zero) {
			Text(placeholder)
				.padding(.leading, 16)
				.opacity(text.isEmpty ? 1 : 0.0001)
				.foregroundStyle(.gray)
			Spacer()
		}
		.allowsHitTesting(false)
	}
}

struct EventifyView: View {
	@State var isValid: Bool = false
	@State var text: String = ""

	var body: some View {
		VStack {
			EventifyTextField(text: $text, placeholder: "Email", isSecure: false)
            EventifyButton(configuration: .commom, isLoading: false, isDisabled: false) {
				isValid.toggle()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(.horizontal)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	EventifyView()
}
