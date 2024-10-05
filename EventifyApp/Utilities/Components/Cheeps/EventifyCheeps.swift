//
//  EventifyCheeps.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyCheeps: View {
	let items: [String]

	let style: CheepsStyle
    let fontSize: CGFloat

	init(items: [String], style: CheepsStyle, fontSize: CGFloat = 12) {
		self.items = items
		self.style = style
        self.fontSize = fontSize
	}

	var body: some View {
		FlowLayout(mode: .vstack, items: items, viewMapping: { items in
			Text(items)
                .font(.mediumCompact(size: fontSize))
				.foregroundStyle(style.titleColor)
				.frame(height: 20)
				.padding(.vertical, 4)
				.padding(.horizontal, 8)
                .background(style != .common ? style.backgroundColor : .clear)
                .clipShape(style != .common ? AnyShape(Capsule()) : AnyShape(Rectangle()))
				.overlay {
					if style == .common {
						Capsule()
							.stroke(
								style: .init(lineWidth: 1)
							)
					} else if style == .upcoming {
						Capsule()
							.stroke(
								style: .init(lineWidth: 1)
							)
					}
				}
		})
	}
}

#Preview {
    EventifyCheeps(items: ["MISOS", "фьючер", "ГОЛЛЛЛЛЛЛЛЛЛЛЛЛЛЛ", "ЛЕГЕНДЫ"], style: .upcoming)
}
