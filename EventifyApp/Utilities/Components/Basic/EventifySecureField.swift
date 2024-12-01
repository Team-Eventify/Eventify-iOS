//
//  EventifySecureField.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 01.10.2024.
//

import SwiftUI

struct EventifySecureField: View {
    @FocusState var isFocused: Bool
    @Binding var text: String
    @State var isSecure: Bool
    let placeholder: String

    private var focusedColor: Color {
        if isFocused {
            return Color.mainText
        } else {
            return Color.gray
        }
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }

            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: isSecure ? "eye" : "eye.slash")
                    .foregroundStyle(.gray)
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

struct EventifySecureView: View {
    @State var isValid: Bool = false
    @State var text: String = ""

    var body: some View {
        VStack {
            EventifySecureField(
                text: $text, isSecure: false, placeholder: "Email")
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
