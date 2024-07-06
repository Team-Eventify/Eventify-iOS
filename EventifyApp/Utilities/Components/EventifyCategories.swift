//
//  EventifyCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 06.07.2024.
//

import SwiftUI

struct EventifyCategories: View {
	let text: String
	let image: String

	var body: some View {
		ZStack {
			HStack(spacing: .zero) {
				Spacer()
				Image(image)
			}
		}
		.frame(maxWidth: .infinity)
		.frame(height: 160)
		.background(.blue)
		.clipShape(.rect(cornerRadius: 10))
		.overlay(alignment: .topLeading) {
			Text(text)
				.font(.mediumCompact(size: 24))
				.padding([.leading, .top], 16)
		}
	}
}

#Preview {
	EventifyCategories(text: "Спорт", image: "sport")
		.padding(.horizontal, 16)
}
