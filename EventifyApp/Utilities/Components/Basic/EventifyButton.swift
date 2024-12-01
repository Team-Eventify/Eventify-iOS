//
//  EventifyButton.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.06.2024.
//

import SwiftUI

struct EventifyButton: View {
    var configuration: ButtonConfigurations
    var isLoading: Bool
	var isDisabled: Bool
	var action: () -> Void

	var body: some View {
		Button {
			action()
		} label: {
			if isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
					.frame(maxWidth: .infinity)
					.padding(.vertical, 13)
					.tint(.black)
                    .background(configuration.color)
					.foregroundStyle(.white)
					.cornerRadius(10)
			} else {
                Text(configuration.title)
					.font(.mediumCompact(size: 17))
					.foregroundColor(.black)
					.padding(.vertical, 13)
					.frame(maxWidth: .infinity)
                    .background(isDisabled ? .gray : configuration.color)
					.cornerRadius(10)
			}
		}
		.disabled(isLoading || isDisabled) // Disable the button when loading
	}
}

#Preview {
	VStack {
        EventifyButton(configuration: .registration, isLoading: false, isDisabled: false, action: {})
        EventifyButton(configuration: .cancel, isLoading: true, isDisabled: false, action: {})
        EventifyButton(configuration: .commom, isLoading: false, isDisabled: false, action: {})
	}
	.padding(.horizontal, 16)
	.background(.bg, ignoresSafeAreaEdges: .all)
}
