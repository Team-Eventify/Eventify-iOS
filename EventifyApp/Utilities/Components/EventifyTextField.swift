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

	private var focusedColor: Color {
		if isFocused {
			return Color.mainText
		} else {
			return  Color.gray
		}
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
			color: focusedColor,
			radius: 10
		)
		.overlay(placeholderTextContainerView)
		.font(.regularCompact(size: 17))
		.foregroundStyle(focusedColor)
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
			EventifyButton(title: "Переключить состояние", isLoading: false, isDisabled: false) {
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
