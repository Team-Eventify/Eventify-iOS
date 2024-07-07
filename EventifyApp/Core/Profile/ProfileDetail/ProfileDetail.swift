//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct ProfileDetail: View {
	@State private var nameText: String = ""
	@State private var surnameText: String = ""
	@State private var emailText: String = ""
	@State private var telegramText: String = ""

	@Environment(\.dismiss)
	var dismiss

    var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Имя")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(text: $nameText, placeholder: "Введите имя", isSucceededValidation: true, isSecure: false)

			Text("Фамилия")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(text: $surnameText, placeholder: "Введите фамилию", isSucceededValidation: true, isSecure: false)

			Text("Email")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(text: $emailText, placeholder: "Введите email", isSucceededValidation: true, isSecure: false)

			Text("Telegram")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(text: $telegramText, placeholder: "Введите email", isSucceededValidation: true, isSecure: false)

			EventifyButton(title: "Сохранить изменения") {
				print("📙 Saved! 📙")
				dismiss()
			}
			Spacer()
			Spacer()
		}
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    ProfileDetail()
}
