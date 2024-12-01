//
//  NoInternetView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.11.2024.
//

import SwiftUI

/// Вью, которое показывается в случае отсутствия
/// соединения с интернетом
struct NoInternetView: View {
	@EnvironmentObject var networkConnection: NetworkManager
	var body: some View {
		VStack(spacing: 16) {
			Spacer()
			Image(systemName: "wifi.slash")
				.font(.system(size: 120))
				.foregroundStyle(.secondaryText)
			Text("no_internet_title")
				.font(.semiboldCompact(size: 20))
				.foregroundStyle(.mainText)
			Text("no_internet_description")
				.font(.semiboldCompact(size: 17))
				.foregroundStyle(.secondaryText)
				.multilineTextAlignment(.center)
			Button {
				networkConnection.checkConnection()
			} label: {
				Text("retry_button_title")
					.font(.mediumCompact(size: 17))
					.foregroundStyle(.black)
					.padding(.vertical, 11)
					.padding(.horizontal, 16)
					.background(.brandCyan)
					.clipShape(.capsule)
			}
			Spacer()
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
    NoInternetView()
		.environmentObject(NetworkManager())
}
