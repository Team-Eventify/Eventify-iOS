//
//  FeedbackView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.11.2024.
//

import SwiftUI
import Pow

struct FeedbackView: View {
    // TODO: сделать EnvironmentObject
	@StateObject private var viewModel: FeedbackViewModel
	@Environment(\.dismiss) var dismiss

	init() {
		_viewModel = .init(wrappedValue: FeedbackViewModel())
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 32) {
			rateEventContainer
			firstFeedbackContainer
			secondFeedbackContainer
			finalFeedbackContainer
			buttonContainer
		}
		.navigationTitle("FeedbackNavigationTitle")
		.navigationBarTitleDisplayMode(.inline)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
		.onTapGesture {
			self.hideKeyboard()
		}
	}

	private var rateEventContainer: some View {
		VStack(alignment: .leading, spacing: 20) {
			HStack(spacing: 0) {
				Text("rateEventTitle")
					.foregroundStyle(viewModel.isError ? .error : .mainText)
					.font(.mediumCompact(size: 20))

				Text("*")
					.foregroundStyle(.error)
					.font(.mediumCompact(size: 20))
			}

			HStack(spacing: 8) {
				ForEach(1...5, id: \.self) { number in
					Button(action: { viewModel.selectedRating = number }) { 
						Text("\(number)")
							.frame(width: 60, height: 60)
							.background(
								RoundedRectangle(cornerRadius: 8)
									.fill(
										viewModel.selectedRating == number
										? Color.brandCyan
											: Color.clear)
							)
							.overlay(
								RoundedRectangle(cornerRadius: 8)
									.stroke(Color.gray, lineWidth: 1)
							)
							.foregroundColor(.primary)
							.changeEffect(.shake(rate: .fast), value: viewModel.submitAttempts)
					}
				}
			}
		}
	}

	private var firstFeedbackContainer: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("feedbackLikeTitle")
				.foregroundStyle(.mainText)
				.font(.mediumCompact(size: 20))

			TextEditor(text: $viewModel.firstFeedbackText)
				.textInputAutocapitalization(.sentences)
				.autocorrectionDisabled(true)
				.scrollContentBackground(.hidden)
				.background(.tabbarBg)
				.frame(height: 95)
				.clipShape(.rect(cornerRadius: 10))
		}
	}

	private var secondFeedbackContainer: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("feedbackDislikeTitle")
				.foregroundStyle(.mainText)
				.font(.mediumCompact(size: 20))

			TextEditor(text: $viewModel.secondFeedbackText)
				.textInputAutocapitalization(.sentences)
				.autocorrectionDisabled(true)
				.scrollContentBackground(.hidden)
				.background(.tabbarBg)
				.frame(height: 95)
				.clipShape(.rect(cornerRadius: 10))
		}
	}

	private var finalFeedbackContainer: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("feedbackFinalTitle")
				.foregroundStyle(.mainText)
				.font(.mediumCompact(size: 20))

			TextEditor(text: $viewModel.finalFeedbackText)
				.textInputAutocapitalization(.sentences)
				.autocorrectionDisabled(true)
				.scrollContentBackground(.hidden)
				.background(.tabbarBg)
				.frame(height: 95)
				.clipShape(.rect(cornerRadius: 10))
		}
	}

	private var buttonContainer: some View {
		EventifyButton(
			configuration: .sendRate, isLoading: false, isDisabled: false
		) {
			Task {
				await viewModel.submitFeedback()
			}
		}
		.onChange(of: viewModel.shouldDismiss) { newValue in
			if newValue {
				dismiss()
			}
		}
	}
}

#Preview {
	FeedbackView()
}
