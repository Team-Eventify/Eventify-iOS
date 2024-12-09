//
//  EventsRegistationView.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

struct EventsRegistationView: View {
	
	let model: EventifyRecommendationModel

	@State private var currentPage = 0
	@State private var isDescriptionExpanded = false

	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 16) {
				photoCarousel
				detailsView
				footerView
			}
		}
		.navigationTitle(model.title)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}

	private var photoCarousel: some View {
		VStack(spacing: 16) {
			TabView(selection: $currentPage) {
				ForEach(0..<model.image.count, id: \.self) { index in
					Image(model.image[index])
						.resizable()
						.scaledToFill()
						.tag(index)
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.frame(height: 250)
			.clipShape(RoundedRectangle(cornerRadius: 10))

			PageControl(numberOfPages: model.image.count, currentPage: $currentPage)
		}
	}

	private var detailsView: some View {
		VStack(alignment: .leading, spacing: 32) {
			EventifyCheeps(items: model.cheepsItems, style: .registation)
			Text(model.description ?? "")
				.font(.regularCompact(size: 17))
				.lineLimit(isDescriptionExpanded ? nil : 10)
				.animation(.easeInOut, value: isDescriptionExpanded)
		}
	}

	private var footerView: some View {
		VStack(alignment: .leading, spacing: 0) {
			Button {
				withAnimation {
					isDescriptionExpanded.toggle()
				}
			} label: {
				Text(
					isDescriptionExpanded
						? String(localized: "less_description_title") + "▲"
						: String(localized: "full_description_title") + "▼"
				)
				.font(.mediumCompact(size: 14))
				.foregroundStyle(.linkButton)
			}

			Text("organizer_title")
				.font(.semiboldCompact(size: 12))
				.foregroundStyle(.secondaryText)
				.padding(.top, 23)

			HStack(spacing: 16) {
				Image("misis")
					.clipShape(Circle())
					.frame(height: 40)
					.padding(.top, 8)

				Text("МИСИС")
					.font(.semiboldCompact(size: 20))
					.foregroundStyle(.mainText)
			}

			EventifyButton(
				configuration: /*model.isRegistered ? */.registration,
				isLoading: false, isDisabled: false
			) {
				print("tapнул хомяка")
			}
			.padding(.top, 24)
		}
	}
}
