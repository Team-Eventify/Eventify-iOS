//
//  EventifyRecommendationEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Вью ячейки организаторов
struct EventifyRecommendationEvent: View {
	let image: String
	let title: String
	let cheepsItems: [String]
	let size: EventCellSize

    var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Image(image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: size.width, height: size.height / 2)
				.clipped()
			Text(title)
				.font(.mediumCompact(size: 14))
				.foregroundStyle(.mainText)
				.padding(.horizontal, 16)
			EventifyCheeps(items: cheepsItems)
				.padding(.horizontal, 16)
			Spacer()
		}
		.frame(width: size.width, height: size.height)
		.background(.cards)
		.clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
	EventifyRecommendationEvent(
		image: "recomm",
		title: "День открытых дверей университета МИСИС", 
		cheepsItems: ["12 декабря", "17:30", "онлайн"],
		size: .large
	)
		.padding(.horizontal, 16)
}
