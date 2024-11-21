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

    var body: some View {
        TextField("", text: $text)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .focused($isFocused)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
			.frame(maxWidth: .infinity)
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
            EventifyTextField(text: $text, placeholder: "Email", hasError: false)
            EventifyButton(
                configuration: .commom, isLoading: false, isDisabled: false
            ) {
                isValid.toggle()
            }
        }
        .padding(.horizontal)
        .background(.bg, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    EventifyView()
}
