//
//  AuthSnackBar.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.09.2024.
//

import SwiftUI

struct EventifySnackBar: View {
	let config: SnackbarConfig
	var body: some View {
		HStack(spacing: 8) {
			Image(config.icon)
				.resizable()
				.frame(width: 50, height: 50)

			Text(config.text)
				.foregroundColor(.mainText)
				.font(.mediumCompact(size: 16))
		}
		.padding(16)
		.background(.snack)
		.cornerRadius(10)
	}
}

#Preview {
	EventifySnackBar(config: .failure)
}
