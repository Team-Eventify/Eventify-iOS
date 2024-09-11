//
//  EventsDetailView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.09.2024.
//

import SwiftUI

struct EventsDetailView: View {
	let name: String

	let cheepsNames: [String] = ["11 сентября", "18:00", "офлайн"]

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			qrView

			VStack(alignment: .leading, spacing: 4) {
				Text("Экскурсия")
					.font(.regularCompact(size: 17))
					.foregroundStyle(.secondaryText)
				Text("Фестиваль ИКН")

				EventifyCheeps(items: cheepsNames, style: .registation)

				Text("nfdujfhgjfgjhkjhkkhjokjropkeolkerjhjigkprfkleqejkwnjjkfgsjkophkdsenjejkkighngphdgigsfdhjvnjk,kwopdgfkknjjkfedjmpepeorrgtskghjklnjdjkfopeolropkrlgtnhhjnmkkfep23olojkrmgesjgjnbjkikpfvo[dolpokqi4wlkirjnrggjghnbcjkgbkfvglcedlpo3kjnbgjbn jvkfpdeeookltgjmhnbjkgmjvfodel3e4qkrgtjf")
					.frame(maxHeight: 300)
					.truncationMode(.tail)

				NavigationLink {
				} label: {
					Text("Перейти к странице мероприятия >")
						.foregroundStyle(.linkButton)
						.font(.semiboldCompact(size: 14))
				}
			}
		}
		.navigationTitle(name)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
    }
}

private var qrView: some View {
	VStack(alignment: .center) {
		Image("qr")
			.resizable()
			.scaledToFill()
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.frame(width: 300, height: 300)
		Divider()
			.foregroundStyle(.gray)
	}
}

#Preview {
	EventsDetailView(name: "Фестиваль  ИКН")
}
