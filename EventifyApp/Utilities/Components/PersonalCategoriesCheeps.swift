//
//  PersonalCategoriesCheeps.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 29.07.2024.
//

import SwiftUI

struct PersonalCategoriesCheeps: View {
	@ObservedObject var viewModel: PersonalCategoriesViewModel
    let category: Categories
    
    private var selectionColor: Color {
        let colors: [Color] = [.brandCyan, .science, .art, .art, .design, .frontend, .backend, .ML, .gameDev, .media, .hackatons, .studLife, .mentoring]
        
        let index = abs(category.id.hashValue) % colors.count
        return colors[index]
    }

	var body: some View {
		Button {
			viewModel.toggleCategorySelection(category)

		} label: {
            Text(category.title)
				.font(.mediumCompact(size: 18))
                .foregroundStyle(viewModel.selectedCategories.contains(category.id) ? .black : .mainText)
		}
		.padding(.vertical, 8)
		.padding(.horizontal, 16)
		.overlay(
			RoundedRectangle(cornerRadius: 24)
				.stroke(lineWidth: 2)
                .foregroundStyle(viewModel.selectedCategories.contains(category.id) ? selectionColor : .mainText)
		)
        .background(viewModel.selectedCategories.contains(category.id) ? selectionColor : .clear)
		.clipShape(RoundedRectangle(cornerRadius: 24))
		.foregroundStyle(.white)
        .shimmer(isActive: viewModel.isLoading)
	}
}
