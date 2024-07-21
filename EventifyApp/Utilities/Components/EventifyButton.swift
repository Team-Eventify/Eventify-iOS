//
//  EventifyButton.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

struct EventifyButton: View {
	let title: String
	var isLoading: Bool
	var action: () -> Void

	var body: some View {
		Button {
			action()
		} label: {
			if isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
					.frame(maxWidth: .infinity)
					.padding(.vertical, 13)
					.tint(.black)
					.background(Color.brandYellow)
					.foregroundStyle(.white)
					.cornerRadius(10)
			} else {
				Text(title)
					.font(.mediumCompact(size: 17))
					.foregroundColor(.black)
					.padding(.vertical, 13)
					.frame(maxWidth: .infinity)
					.background(Color.brandYellow)
					.cornerRadius(10)
			}
		}
		.disabled(isLoading) // Disable the button when loading
	}
}

#Preview {
	VStack {
		EventifyButton(title: "Зарегистрироваться", isLoading: false, action: {})
		EventifyButton(title: "Войти", isLoading: true, action: {})
		EventifyButton(title: "Отправить", isLoading: false, action: {})
	}
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.padding(.horizontal, 16)
	.background(.bg, ignoresSafeAreaEdges: .all)
}
