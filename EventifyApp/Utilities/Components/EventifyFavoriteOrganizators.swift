//
//  EventifyFavoriteOrganizators.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 22.08.2024.
//

import SwiftUI

/// Вью избранного организатора
struct EventifyFavoriteOrganizators: View {
	@State private var isLiked: Bool = false

	let image: String
	let name: String
	let size: EventCellSize
	let items: [String]
	var body: some View {
		VStack {
			VStack(alignment: .trailing, spacing: 8) {
				Image(image)
					.frame(maxWidth: 100, maxHeight: 100)
					.clipShape(Circle())
			}

			Text(name)
				.font(.semiboldCompact(size: 17))
				.padding(.top, 16)

			EventifyCheeps(items: items, style: .common)
				.padding(.top, 21)
				.padding(.leading, 16)

		}
		.frame(width: size.width, height: size.height)
		.background(.cards)
		.clipShape(.rect(cornerRadius: 20))
		.overlay(alignment: .topTrailing) {
			Button {
				isLiked.toggle()
			} label: {
				Image(
					systemName: isLiked 
					? "heart"
					: "heart.fill"
				)
					.tint(.brandPink)
					.imageScale(.large)
			}
			.padding(12)
		}
	}
}

#Preview("large") {
	EventifyFavoriteOrganizators(image: "itam", name: "ITAM", size: .large, items: ["backend", "frontend", "design", "mobile"])
}
