//
//  Favorites.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
		NavigationStack {
			VStack {
				Text("❤️ Favorites Screen ❤️")
					.font(.semiboldCompact(size: 24))
					.foregroundStyle(.mainText)
			}
			.navigationTitle("Избранное")
			.navigationBarTitleDisplayMode(.large)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg)
		}
    }
}

#Preview {
    FavoritesView()
}
