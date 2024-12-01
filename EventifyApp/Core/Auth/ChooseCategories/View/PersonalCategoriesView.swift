//
//  ChooseCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.07.2024.
//

import Flow
import PopupView
import SwiftUI

struct PersonalCategoriesView: View {
	// MARK: - Private Properties
	@EnvironmentObject private var networkManager: NetworkManager
	@EnvironmentObject private var coordinator: AppCoordinator

	/// ViewModel для управления логикой вью
	@StateObject private var viewModel: CategoriesViewModel

	init(viewModel: CategoriesViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

	// MARK: - Body

	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
        } else {
            VStack(alignment: .leading, spacing: 40) {
                Spacer()
                headerContainer
                cheepsSection
                descriptionSection
                footerContainer
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(.bg, ignoresSafeAreaEdges: .all)
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.getCategories()
            }
        }
	}

	private var headerContainer: some View {
		VStack(alignment: .leading, spacing: 21) {
			Text("choose_categories_title")
				.font(.mediumCompact(size: 35))
				.foregroundStyle(.mainText)

			Text("choose_categories_subtitle")
				.font(.regularCompact(size: 17))
				.foregroundStyle(.secondaryText)
		}
	}

	private var cheepsSection: some View {
		VStack(alignment: .leading, spacing: 0) {
			if viewModel.isLoading {
				// Показываем заглушки при загрузке
				HFlow {
					ForEach(0..<6) { _ in
						RoundedRectangle(cornerRadius: 24)
							.fill(Color.gray.opacity(0.3))
							.frame(width: 120, height: 45)
							.shimmer(isActive: true)
					}
				}
			} else {
				HFlow {
					ForEach(viewModel.categories) { category in
						PersonalCategoriesCheeps(
							viewModel: viewModel, category: category)
					}
				}
			}
		}
	}

	private var descriptionSection: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text("choose_categories_description")
				.font(.regularCompact(size: 17))
				.foregroundStyle(.secondaryText)
		}
	}

	private var footerContainer: some View {
		VStack(spacing: 24) {
			EventifyButton(
				configuration: .commom, isLoading: false,
				isDisabled: !viewModel.isAnyCategorySelected
			) {
				viewModel.setUserCategories()
				viewModel.authenticate(coordinator: coordinator)
			}
			Button {
				viewModel.authenticate(coordinator: coordinator)
			} label: {
				Text("skip_title")
					.foregroundStyle(.gray)
					.font(.mediumCompact(size: 17))
					.underline()
			}
		}
	}
}
