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
                    contentForUpcomingEventsSection
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

/// Функция для отображения секции предстоящих мероприятий
@ViewBuilder
private var contentForUpcomingEventsSection: some View {
    if MyEventsMockData.upcomingEventsData.isEmpty {
        emptyUpcomingEvents
    } else {
        upcomingEvents
    }
}

/// Карточки предстоящих мероприятий
private var upcomingEvents: some View {
	VStack(alignment: .leading) {
		Text("Предстоящие мероприятия")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		LazyVStack(spacing: 8) {
			ForEach(MyEventsMockData.upcomingEventsData) { event in
                NavigationLink {
                    EventsRegistationView(register: false)
                } label: {
                    EventifyUpcomingEvent(title: event.title, items: event.cheepTitles)
                }
                .buttonStyle(.plain)
			}
		}
	}
}

/// Вью, которое показывается в случае отсутствия
/// предстоящих мероприятий
private var emptyUpcomingEvents: some View {
    VStack {
        Image(systemName: "bookmark")
            .font(.system(size: 60))
        Text("Нет предстоящих\nмероприятий")
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.top, 5)
    }
    .foregroundStyle(.secondary)
    .padding(80)
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
                        EventsRegistationView(register: true)
					} label: {
						EventifyRecommendationEvent(
							image: event.image,
							title: event.title,
							cheepsItems: event.cheepsItems,
							size: .large
						)
					}
                    .buttonStyle(.plain)
				}
			}
		}
	}
}

#Preview {
	TabBarView()
}
