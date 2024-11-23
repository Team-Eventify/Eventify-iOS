//
//  DebugMenuView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 23.11.2024.
//

import SwiftUI

struct DebugMenuView: View {
	var body: some View {
		List {
			Section {
				NavigationLink {
					CoreDataView()
				} label: {
					Text("Core Data")
				}
			}
		}
		.navigationTitle("Debug Menu")
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	DebugMenuView()
}
