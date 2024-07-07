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
	let color: Color

	var body: some View {
		ZStack {
			HStack(spacing: .zero) {
				Spacer()
				Image(image)
			}
		}
		.frame(maxWidth: .infinity)
		.frame(height: 160)
		.background(color)
		.clipShape(.rect(cornerRadius: 10))
		.overlay(alignment: .topLeading) {
			Text(text)
				.font(.mediumCompact(size: 24))
				.foregroundColor(.white)
				.padding([.leading, .top], 16)
		}
	}
}

#Preview {
	EventifyCategories(text: "Наука", image: "science", color: .science)
		.padding(.horizontal, 16)
}
