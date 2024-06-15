//
//  EventifyTextField.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

struct EventifyTextField: View {
    @Binding var text: String
    let placeholder: String
    let isSucceededValidation: Bool
    
    var body: some View {
        TextField("", text: $text)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .background(.white)
            .overlay( // TODO: Сделать модифаер setBorder, который принимает ширину линии + цвет + радиус
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSucceededValidation ? Color.gray : Color.red, lineWidth: 1)
            )
            .overlay(placeholderTextContainerView)
            .font(.regularCompact(size: 17))
            .foregroundStyle(isSucceededValidation ? .gray : .red)
    }
    
    private var placeholderTextContainerView: some View {
        HStack(spacing: .zero) {
            Text(placeholder)
                .padding(.leading, 16)
                .opacity(text.isEmpty ? 1 : 0.0001)
            Spacer()
        }
    }
}

struct EventifyView: View {
    @State var isValid: Bool = false
    @State var text: String = ""
    
    var body: some View {
        VStack {
            EventifyTextField(text: $text, placeholder: "Email", isSucceededValidation: !isValid)
            EventifyButton(title: "Переключить состояние") {
                isValid.toggle()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    EventifyView()
}
