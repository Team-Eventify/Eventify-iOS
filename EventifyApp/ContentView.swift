//
//  ContentView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var appCoordinator: AppCoordinator
	
	var body: some View {
		appCoordinator.build()
	}
}

#Preview {
	ContentView()
}
