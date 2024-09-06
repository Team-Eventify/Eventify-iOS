//
//  EventifyCheeps.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyCheeps: View {
	let items: [String]

	init(items: [String]) {
		self.items = items
	}

	var body: some View {
		FlowLayout(mode: .vstack, items: items, viewMapping: { items in
			Text(items)
				.font(.mediumCompact(size: 12))
				.frame(height: 20)
				.padding(.horizontal, 8)
				.overlay {
					Capsule()
						.stroke(
							style: .init(lineWidth: 1)
						)
				}
		})
	}
}

#Preview {
    EventifyCheeps(items: ["ГЛЕБУСССС", "СПАСИБОООО", "ГОЛЛЛЛЛЛЛЛЛЛЛЛЛЛЛ", "ПРИКОЛЛЛЛЛЛЛЛЛЛЛЛЛЛЛ"])
}
