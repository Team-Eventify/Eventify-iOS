//
//  AuthSnackBar.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.09.2024.
//

import SwiftUI

struct AuthSnackBar: View {
	var body: some View {
		HStack(spacing: 8) {
			Image(systemName: "faceid")
				.resizable()
				.foregroundColor(.brandYellow)
				.frame(width: 30, height: 30)

			Text("Ошибка авторизации, проверьте почту или пароль на верность")
				.foregroundColor(.white)
				.font(.mediumCompact(size: 14))
		}
		.padding(16)
		.background(Color.snack)
		.cornerRadius(12)
	}
}

#Preview {
	AuthSnackBar()
}
