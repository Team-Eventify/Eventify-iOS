//
//  PersonalCategoriesCheeps.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 29.07.2024.
//

import SwiftUI

struct PersonalCategoriesCheeps: View {
	@ObservedObject var viewModel: PersonalCategoriesViewModel
	let category: PersonalCategories

	var body: some View {
		Button {
			viewModel.toggleCategorySelection(category)

		} label: {
			Text(category.name)
				.font(.mediumCompact(size: 16))
				.foregroundStyle(.mainText)
		}
		.padding(.vertical, 8)
		.padding(.horizontal, 16)
		.overlay(
			RoundedRectangle(cornerRadius: 24)
				.stroke(lineWidth: 2)
				.foregroundStyle(viewModel.selectedCategories.contains(category) ? category.selectionColor : .mainText)
		)
		.background(viewModel.selectedCategories.contains(category) ? category.selectionColor : .clear)
		.clipShape(RoundedRectangle(cornerRadius: 24))
		.foregroundStyle(.white)
	}
}
