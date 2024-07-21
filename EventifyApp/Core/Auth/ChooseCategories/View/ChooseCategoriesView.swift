//
//  ChooseCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import SwiftUI

struct ChooseCategoriesView: View {
    var body: some View {
		VStack(alignment: .leading, spacing: 21) {
			Text("Выбери интересные\nтебе категории!")
				.font(.mediumCompact(size: 40))
				.foregroundStyle(.mainText)

			Text("Мы подберём рекомендации ивентов\nпод твои вкусы.")
				.font(.regularCompact(size: 17))

			EventifyButton(title: "Далее", isLoading: false) {

			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(.horizontal, 16)
		.background(.bg, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    ChooseCategoriesView()
}
