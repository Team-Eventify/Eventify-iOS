//
//  MainView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

struct TabBarView: View {
	@State private var selectedTab: Tab = .main
	var body: some View {
		tabbarContent
			.navigationBarBackButtonHidden()
	}
}

private extension TabBarView {
	var tabbarContent: some View {
		VStack(spacing: 0) {
			TabbarScreens(contentMode: selectedTab)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			HStack {
				buttons
			}
			.padding(.horizontal, 20)
			.padding(.top, 7)
			.frame(height: 83, alignment: .top)
			.background(Color.bg)
			.cornerRadius(10, corners: [.topLeft, .topRight])
			.shadow(color: .white.opacity(0.15), radius: 1, x: 0, y: -0.33)
		}
		.ignoresSafeArea(edges: .bottom)
	}

	var buttons: some View {
		ForEach(Tab.allCases, id: \.self) { item in
			TabButton(item: item, selectedTab: $selectedTab)
		}
	}
}

#Preview {
	TabBarView()
}
