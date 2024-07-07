//
//  MyEvents.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

struct MyEventsView: View {
	var body: some View {
		NavigationStack {
			VStack(alignment: .leading, spacing: 56) {
				ScrollView(showsIndicators: false) {
					upcomingEvents
					recomendedEvents
					Spacer()
				}
			}
			.navigationTitle("Мои ивенты")
			.navigationBarTitleDisplayMode(.large)
			.padding(.horizontal, 16)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
		}
	}
}

private var upcomingEvents: some View {
	VStack(alignment: .leading, spacing: 24) {
		Text("Предстоящие мероприятия")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		VStack(spacing: 8) {
			ForEach(MyEventsMockData.upcomingEventsData) {
				EventifyUpcomingEvent(title: $0.title, items: $0.cheepTitles, color: $0.color)
			}
		}
	}
}

private var recomendedEvents: some View {
	VStack(alignment: .leading) {
		Text("Рекомедации")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
	}
}

#Preview {
	TabBarView()
}
