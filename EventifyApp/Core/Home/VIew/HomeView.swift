//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import PopupView
import SwiftUI

/// Вью главного экрана
struct HomeView: View {
	// MARK: - Private Properties

	@EnvironmentObject private var viewModel: HomeViewModel
	@EnvironmentObject private var coordinator: AppCoordinator
	@EnvironmentObject private var networkManager: NetworkConnection

	// MARK: - Body

    var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
        } else if viewModel.events.isEmpty {
            noUpcomingEvents
        } else {
            ScrollView {
                popularEventsSection
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
            .navigationTitle(String(localized: "tab_main"))
            .navigationBarTitleDisplayMode(.large)
            .background(.bg, ignoresSafeAreaEdges: .all)
            .refreshable {
                viewModel.fetchEventsList()
            }
        }
    }

    private var noUpcomingEvents: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock.fill")
                .foregroundStyle(.secondaryText)
                .font(.system(size: 52))
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.secondaryText, lineWidth: 2)
                )
            Text("no_upcoming_events_message")
                .font(.semiboldCompact(size: 20))
            Text("no_events_scheduled_message")
                .font(.mediumCompact(size: 16))
                .foregroundStyle(.secondaryText)
                .multilineTextAlignment(.center)
            Button {
                viewModel.fetchEventsList()
            } label: {
                Text("refresh_title")
                    .font(.mediumCompact(size: 17))
                    .foregroundStyle(.black)
                    .padding(.vertical, 11)
                    .padding(.horizontal, 16)
                    .background(.brandCyan)
                    .clipShape(.capsule)
            }
        }
    }
    
	private var popularEventsSection: some View {
		VStack(alignment: .leading) {
			Text("popular_events_title")
				.font(.mediumCompact(size: 20))
				.padding(.bottom, 10)

			if viewModel.isLoading {
				RoundedRectangle(cornerRadius: 10)
					.frame(height: 250)
					.shimmer(isActive: viewModel.isLoading)

				RoundedRectangle(cornerRadius: 10)
					.frame(height: 250)
					.shimmer(isActive: viewModel.isLoading)

				RoundedRectangle(cornerRadius: 10)
					.frame(height: 250)
					.shimmer(isActive: viewModel.isLoading)
			} else {
				LazyVStack(spacing: 30) {
					ForEach(viewModel.events) { event in
						Button {
							let eventService = EventService()
							coordinator.push(.eventsDetail(event, eventService))
						} label: {
							EventifyRecommendationEvent(
								configuration: event.asDomain())
						}
						.foregroundStyle(.clear)
					}
				}
			}
		}
		.padding(.top, 10)
		.padding(.bottom, 20)
	}
}
