//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		NavigationStack {
			VStack {
				Text("📺 Main Screen 📺")
					.font(.semiboldCompact(size: 24))
					.foregroundStyle(.mainText)
			}
			.navigationTitle("Главная")
			.navigationBarTitleDisplayMode(.large)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
		}
	}
}

#Preview {
	MainView()
}
