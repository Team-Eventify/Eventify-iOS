//
//  EventifyFavoriteOrganizators.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 22.08.2024.
//

import SwiftUI

/// Вью избранного организатора
struct EventifyFavoriteOrganizators: View {
	let image: String
	let name: String
	let size: EventCellSize
	let items: [String]
	var body: some View {
		VStack {
			VStack(alignment: .trailing, spacing: 8) {
				Button {
					print("Tapped!")
				} label: {
					Image(systemName: "heart")
						.tint(.brandPink)
				}
				.padding(.trailing, 4)

				Image(image)
					.frame(maxWidth: 100, maxHeight: 100)
					.clipShape(Circle())
			}

			Text(name)
				.font(.semiboldCompact(size: 17))
				.padding(.top, 16)

			EventifyCheeps(items: items)
				.padding(.top, 21)

		}
		.frame(width: size.width, height: size.height)
		.background(.cards)
		.clipShape(.rect(cornerRadius: 20))
	}
}

#Preview("large") {
	EventifyFavoriteOrganizators(image: "itam", name: "ITAM", size: .large, items: ["backend", "frontend", "design"])
}
