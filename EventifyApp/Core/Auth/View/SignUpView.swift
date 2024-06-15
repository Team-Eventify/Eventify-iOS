//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var emailText: String = ""
    @State private var passwordText: String = ""

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 60) {
                registrationContentContainerView
                registrationButtonContainerView
            }
            .foregroundStyle(Color.secondaryText)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
    }
    
    private var registrationContentContainerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Регистрация")
                .font(.semiboldCompact(size: 40))
                .foregroundStyle(Color.mainText)

            Text("Пожалуйста, создайте новый аккаунт. Это займёт меньше минуты.")
                .font(.regularCompact(size: 17))
                .frame(width: 296)
        }
    }
    
    private var registrationButtonContainerView: some View {
        VStack(spacing: 20) {
            EventifyButton(title: "Зарегистрироваться") {
                print("Tapped")
            }

            haveAccountContainerView
        }
    }

    private var haveAccountContainerView: some View {
        HStack(spacing: 12) {
            Text("Уже есть аккаунт?")
                .font(.regularCompact(size: 16))
            Button {
                print("Войти tapped!")
            } label: {
                Text("Войти")
                    .underline()
                    .font(.mediumCompact(size: 16))
                    .foregroundStyle(Color.brandYellow)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SignUpView()
}
