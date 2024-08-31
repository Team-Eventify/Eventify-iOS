//
//  Main.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью главного экрана
struct MainView: View {
	// MARK: - Body

	var body: some View {
			VStack(spacing: 16) {
				Text("📺 Main Screen 📺")
					.font(.semiboldCompact(size: 24))
					.foregroundStyle(.mainText)
				Text("⚠️ Work in progress ⚠️")
					.font(.semiboldCompact(size: 16))
					.foregroundStyle(.foreground)
			}
			.navigationTitle("Главная")
			.navigationBarTitleDisplayMode(.large)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	MainView()
}
