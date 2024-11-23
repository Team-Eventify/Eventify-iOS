//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import PopupView
import SwiftUI

/// Вью главного экрана
struct MainView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel: MainViewModel
	@EnvironmentObject private var networkManager: NetworkManager
	@Binding private var selectedTab: Tab

	// MARK: - Body

	/// Инициализирует MainView с сервисом категорий и привязкой активной вкладки
	init(eventsService: EventsServiceProtocol, selectedTab: Binding<Tab>) {
		_selectedTab = selectedTab
		_viewModel = StateObject(
			wrappedValue: MainViewModel(eventsService: eventsService))
	}

	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
        } else {
            ScrollView {
                popularEventsSection
                categoriesSection
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
					ForEach(viewModel.events) {
						EventifyRecommendationEvent(
							configuration: $0.asDomain())
					}
				}
			}
		}
		.padding(.top, 10)
		.padding(.bottom, 20)
	}

	private var categoriesSection: some View {
		VStack(alignment: .leading) {
			Text("categories_based_on_interests")
				.font(.mediumCompact(size: 20))
			LazyVStack(spacing: 10) {
				ForEach(viewModel.interestsCategories()) {
					EventifyCategories(configuration: $0.asDomain())
				}
				Button {
					withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
						selectedTab = .search
					}
				} label: {
					HStack(spacing: 4) {
						Text("see_more_categories_button")
							.font(.mediumCompact(size: 14))
							.bold()
						Image(systemName: "chevron.right")
					}
					.foregroundStyle(.accent)
				}
			}
		}
		.padding(.bottom, 20)
	}
}

#Preview {
	TabBarView()
		.environmentObject(NetworkManager())
}
