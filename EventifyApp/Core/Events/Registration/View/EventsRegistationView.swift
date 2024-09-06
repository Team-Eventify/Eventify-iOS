//
//  EventsRegistationView.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

struct EventsRegistationView: View {
	@State private var currentPage = 0

	let name: String
	let eventImages = ["poster", "poster", "poster"]
	let cheepsTitles: [String] = ["11 сентября", "18:30", "офлайн"]

	var body: some View {
		VStack(alignment: .center, spacing: 16) {
			TabView(selection: $currentPage) {
				ForEach(0 ..< eventImages.count, id: \.self) { index in
					Image(eventImages[index])
						.resizable()
						.scaledToFill()
						.tag(index)
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.frame(height: 250)
			.clipShape(RoundedRectangle(cornerRadius: 10))

			PageControl(numberOfPages: eventImages.count, currentPage: $currentPage)

			EventifyCheeps(items: cheepsTitles, style: .registation)
			Text("Дни открытых дверей — это уникальная возможность для старшеклассников больше узнать о специальностях, которым обучают в одном из лучших технических университетов России, научной деятельности под руководством учёных с мировым именем, образовательных проектах и карьерных возможностях, которые предлагает вуз, яркой студенческой жизни в Москве.")
				.font(.regularCompact(size: 17))
			footerView
		}
		.navigationTitle(name)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

private var footerView: some View {
	VStack(alignment: .leading, spacing: 0) {
		NavigationLink {
			TestView()
		} label: {
			Text("Полное описание >")
				.font(.mediumCompact(size: 14))
				.foregroundStyle(.linkButton)
		}

		Text("Организатор")
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

		EventifyButton(title: "Записаться на ивент", isLoading: false, isDisabled: false) {
			print("Register success ✅")
		}
		.padding(.top, 24)
	}
}

#Preview {
	EventsRegistationView(name: "День открытых дверей МИСИС")
}
