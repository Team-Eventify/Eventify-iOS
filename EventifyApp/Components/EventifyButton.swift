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
				.font(.mediumCompact(size: 17))
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
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.padding(.horizontal, 16)
	.background(Color.background, ignoresSafeAreaEdges: .all)
}
