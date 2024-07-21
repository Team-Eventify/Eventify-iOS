//
//  ProfileDetail.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Вью детального экрана профиля
struct ProfileDetail: View {
	// MARK: - Private Properties

	@StateObject private var viewModel: ProfileDetailViewModel

	@Environment(\.dismiss)
	var dismiss

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter viewModel: модель детального экрана профиля
	init(viewModel: ProfileDetailViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? ProfileDetailViewModel()
		)
	}

	// MARK: - Body

    var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Имя")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(
				text: $viewModel.name,
				placeholder: "Введите имя",
				isSucceededValidation: true,
				isSecure: false
			)

			Text("Фамилия")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(
				text: $viewModel.surname,
				placeholder: "Введите фамилию",
				isSucceededValidation: true,
				isSecure: false
			)

			Text("Email")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(
				text: $viewModel.email,
				placeholder: "Введите email",
				isSucceededValidation: true,
				isSecure: false
			)

			Text("Telegram")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)
			EventifyTextField(
				text: $viewModel.telegram,
				placeholder: "Введите email",
				isSucceededValidation: true,
				isSecure: false
			)

			EventifyButton(title: "Сохранить изменения", isLoading: false) {
				print("📙 Saved! 📙")
				dismiss()
			}
			Spacer()
			Spacer()
		}
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    ProfileDetail()
}
