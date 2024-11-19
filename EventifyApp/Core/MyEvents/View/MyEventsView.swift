//
//  MyEvents.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import PopupView
import SwiftUI

/// Вью экрана "Мои Ивенты"
struct MyEventsView: View {
	@EnvironmentObject private var networkManager: NetworkManager

	// MARK: - Body

	var body: some View {
		VStack(alignment: .leading, spacing: 56) {
            if networkManager.isDisconnected {
                noInternetView
            } else {
                ScrollView(showsIndicators: false) {
                    contentForUpcomingEventsSection
                    recomendedEvents
                    Spacer()
                }
            }
		}
		.navigationTitle(String(localized: "tab_my_events"))
		.navigationBarTitleDisplayMode(.large)
		.padding(.horizontal, 16)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.popup(isPresented: $networkManager.isDisconnected) {
			InternetErrorToast()
		} customize: {
			$0.type(.toast)
				.disappearTo(.topSlide)
				.position(.top)
		}
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

/// Вью, которое показывается в случае отсутствия
/// предстоящих мероприятий
private var emptyUpcomingEvents: some View {
	VStack {
		Image(systemName: "bookmark")
			.font(.system(size: 60))
		Text("no_upcoming_events_message")
			.font(.body)
			.multilineTextAlignment(.center)
			.padding(.top, 5)
	}
	.foregroundStyle(.secondary)
	.padding(80)
}

/// Вью, которое показывается в случае отсутствия
/// соединения с интернетом
private var noInternetView: some View {
    VStack {
        Spacer()
        Image(systemName: "wifi.slash")
            .font(.system(size: 120))
            .foregroundStyle(.secondaryText)
            .padding(.bottom, 16)
        Text("no_internet_title")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.bottom, 16)
        Text("no_internet_description")
            .multilineTextAlignment(.center)
            .font(.body)
            .fontWeight(.semibold)
            .foregroundStyle(.secondaryText)
            .padding(.bottom, 16)
        Button {
            
        } label: {
            Text("retry_button_title")
                .fontWeight(.medium)
                .padding(10)
                .padding(.horizontal, 5)
                .foregroundStyle(.mainText)
                .background(Capsule())
        }
        Spacer()
    }
    .frame(maxWidth: .infinity)
}

/// Карточки предстоящих мероприятий
private var upcomingEvents: some View {
	VStack(alignment: .leading) {
		Text("upcoming_events_title")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		LazyVStack(spacing: 8) {
			ForEach(MyEventsMockData.upcomingEventsData) { event in
				NavigationLink {
					EventsRegistationView(
						title: event.title,
						cheepsTitles: event.cheepTitles,
						eventImages: event.eventImages,
						description: event.description,
						isRegistered: false
					)
				} label: {
					EventifyRegisteredCard(
						title: event.title,
						items: event.cheepTitles
					)
				}
				.buttonStyle(.plain)
			}
		}
	}
}

/// Карточки рекомендуемых мероприятий
private var recomendedEvents: some View {
	VStack(alignment: .leading) {
		Text("recommendation_title")
			.font(.mediumCompact(size: 20))
			.foregroundStyle(.mainText)
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHStack(spacing: 8) {
				ForEach(MyEventsMockData.recommendedEventsData) { event in
					NavigationLink {
						// TODO: Адаптировать модели для передачи в RegistrationView
						EmptyView()
					} label: {
						EventifyRecommendationEvent(
							configuration: event.asDomain())
					}
					.buttonStyle(.plain)
				}
			}
		}
	}
}

#Preview {
	TabBarView()
		.environmentObject(NetworkManager())
}
