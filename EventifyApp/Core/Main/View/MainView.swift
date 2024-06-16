//
//  MainView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		VStack {
			Text("Main Screen")
				.font(.semiboldCompact(size: 40))
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.background, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
    MainView()
}
