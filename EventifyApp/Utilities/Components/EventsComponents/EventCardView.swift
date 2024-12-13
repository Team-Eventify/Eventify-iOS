//
//  EventifyRecommendationEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventCardView: View {
	let configuration: EventCardConfiguration
	
	init(configuration: EventCardConfiguration) {
		self.configuration = configuration
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			Image(configuration.image[0])
				.resizable()
				.scaledToFill()
				.cornerRadius(16)
			
			detailsText
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: 404)
	}
	
	@ViewBuilder
	private var detailsText: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(configuration.title)
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
				.lineLimit(1)
			
			if configuration.description != nil {
				Text(configuration.description ?? "")
					.font(.regularCompact(size: 17))
					.foregroundStyle(.mainText)
					.multilineTextAlignment(.leading)
					.lineLimit(4)
			}
			
			EventifyCheeps(items: configuration.cheepsItems, style: .common)
		}
		.padding(.horizontal, 2)
	}
}

#Preview {
	EventCardView(
		configuration: .init(
			id: "1",
			cover: "ac22cf22-c7e6-403c-87bc-9c4ca4eb5c37",
			image: ["example"],
			title: "Test Title",
			description: "jdsuhfdgufhrqewiifrguthfrweuqwjiwdefjgbkjhqi qjkofbjfujdhvckjJDASKLdjkldfjsgjfdjjkasjkhsdudfhdgujhwiqhIUEfhrgijjefikwhquwdehfrgtiohjgfidsjaSDHFURGHJWHEAJHSDHJhjhjsdfjhgjerwjjwjdjkfgjkjkdesjnjiusfdjgjiewjd",
			cheepsItems: ["1 января", "9:31", "онлайн"]
		)
	)
}
