//
//  FeedbackViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.11.2024.
//

import Foundation

final class FeedbackViewModel: ObservableObject {
	@Published var selectedRating: Int? = nil
	@Published var firstFeedbackText: String = ""
	@Published var secondFeedbackText: String = ""
	@Published var finalFeedbackText: String = ""

	@Published var submitAttempts = 0
	@Published var isError: Bool = false
	@Published var shouldDismiss: Bool = false

	func submitFeedback() async {
		guard selectedRating != nil else {
			submitAttempts += 1
			isError = true
			try? await Task.sleep(nanoseconds: 1_500_000_000)
			isError = false

			return
		}

		shouldDismiss = true
		print("OK!")
	}
}
