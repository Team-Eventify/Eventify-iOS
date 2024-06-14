//
//  SignUpView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI

struct SignUpView: View {
	@State private var emailText: String = ""
	@State  private var passwordText: String = ""

    var body: some View {
		ZStack {
			Color.background.ignoresSafeArea()

			VStack(alignment: .leading) {
				VStack(alignment: .leading, spacing: 0) {
					Text("Регистрация")
						.font(.custom(Fonts.semibold, size: 40))
						.foregroundStyle(Color.mainText)

					Text("Пожалуйста, создайте новый аккаунт.\nЭто займёт меньше минуты.")
						.font(.custom(Fonts.regular, size: 17))
						.foregroundStyle(Color.secondaryText)
						.padding(.top, 12)

				}
				EventifyButton(title: "Зарегистрироваться") {
					print("Tapped")
				}
				.padding(.top, 60)

				HStack(spacing: 12) {
					Text("Уже есть аккаунт?")
						.font(.custom(Fonts.regular, size: 16))
						.foregroundStyle(Color.secondaryText)
					Button {
						print("Войти tapped!")
					} label: {
						Text("Войти")
							.underline()
							.font(.custom(Fonts.medium, size: 16))
							.foregroundStyle(Color.brandYellow)
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.top, 20)
			}
			.frame(maxWidth: .infinity)
			.padding(.horizontal, 16)
		}
    }
}

#Preview {
	SignUpView()
}
