//
//  EventifyWaitingEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyUpcomingEvent: View {
	let title: String
	let items: [String]
	let color: Color
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 16) {
				Text(title)
					.font(.mediumCompact(size: 17))
					.foregroundStyle(.black)
					.lineLimit(3)
					.padding(.trailing, 4)
					.frame(height: 45)
				EventifyCheeps(items: items)
					.foregroundStyle(.black)
			}
			Spacer()
			Image("qrSample")
		}
		.frame(maxWidth: .infinity)
		.frame(height: 112)
		.padding(.horizontal, 16)
		.background(color)
		.clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
	EventifyUpcomingEvent(
		title: "День открытых дверей университета МИСИС",
		items: ["12 декабря", "17:30", "онлайн"],
		color: .brandYellow
	)
		.padding(.horizontal, 16)
}
