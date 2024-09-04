//
//  MyEvents.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью экрана "Мои Ивенты"
struct MyEventsView: View {

	// MARK: - Body

	var body: some View {
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

// MARK: - UI Components

/// Карточки предстоящих мероприятий
private var upcomingEvents: some View {
	VStack(alignment: .leading) {
		Text("Предстоящие мероприятия")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		LazyVStack(spacing: 8) {
			ForEach(MyEventsMockData.upcomingEventsData) {
				EventifyUpcomingEvent(title: $0.title, items: $0.cheepTitles, color: $0.color)
			}
		}
	}
}

/// Карточки рекомендуемых мероприятий
private var recomendedEvents: some View {
	VStack(alignment: .leading) {
		Text("Рекомедации")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHStack(spacing: 8) {
				ForEach(MyEventsMockData.recommendedEventsData) { event in
					NavigationLink {
						EventsRegistationView(name: event.title)
					} label: {
						EventifyRecommendationEvent(
							image: event.image,
							title: event.title,
							cheepsItems: event.cheepsItems,
							size: .large
						)
					}
					.buttonStyle(PlainButtonStyle())
				}
			}
		}
	}
}

#Preview {
	TabBarView()
}
