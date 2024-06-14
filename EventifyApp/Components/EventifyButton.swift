//
//  EventifyButton.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

struct EventifyButton: View {
	let title: String
	var action: () -> ()

    var body: some View {
		Button {
			action()
		} label: {
			Text(title)
				.font(.custom(Fonts.medium, size: 17))
				.foregroundStyle(.black)
				.padding(.vertical, 13)
				.frame(maxWidth: .infinity)
				.background(Color.brandYellow)
				.cornerRadius(10)
		}
    }
}

#Preview {
	VStack {
		EventifyButton(title: "Зарегистрироваться", action: {})
		EventifyButton(title: "Войти", action: {})
		EventifyButton(title: "Отправить", action: {})
	}
	.padding(.horizontal, 16)
}
