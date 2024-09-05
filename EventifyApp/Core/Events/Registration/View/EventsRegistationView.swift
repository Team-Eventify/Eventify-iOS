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
	let eventImages = ["recomm", "sport", "itam"]
	let cheepsTitles: [String] = ["2 марта", "17:30", "Б-3"]

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
			Text("Доавоалвдладлалвоалвоаловлаовоаровроравропрроарропооалащыллшаооывоаооывлоарвыолаорвыаорораоыроарыоароыраорыорвораорывоароыврыороаыоврлорвыарврвоыароврыоарыолароыроаврыораолыроыоыарволваролыварораолраовроыарлаорыв")
				.font(.mediumCompact(size: 16))
			footerView
		}
		.navigationTitle(name)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

private var footerView: some View {
	VStack(alignment: .leading, spacing: 16) {
		NavigationLink {
			TestView()
		} label: {
			Text("Полное описание >")
				.foregroundStyle(.linkButton)
		}

		EventifyButton(title: "Зарегистрироваться", isLoading: false, isDisabled: false) {
			print("Register success ✅")
		}
	}
}

#Preview {
	EventsRegistationView(name: "День открытых дверей МИСИС")
}
