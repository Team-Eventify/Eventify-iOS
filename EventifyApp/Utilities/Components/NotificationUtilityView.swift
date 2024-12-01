//
//  NotificationUtilityView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.11.2024.
//

import SwiftUI

struct NotificationUtilityView: View {

	var body: some View {
		VStack {
			Text("Fcm token: \(String(describing: UserDefaultsManager.shared.getFcmToken()))")
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	NotificationUtilityView()
}
