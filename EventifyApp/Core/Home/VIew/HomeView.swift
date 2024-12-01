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
	@EnvironmentObject private var networkManager: NetworkManager

	// MARK: - Body

	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
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
}
