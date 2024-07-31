//
//  Profile.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI

/// Вью экрана "Профиль"
struct ProfileView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel = ProfileViewModel()
	@StateObject private var colorScheme = AppColorScheme.shared

	// MARK: - Initialization


	/// Инициализатор
	/// - Parameter viewModel: модель экрана профиля
	init(viewModel: ProfileViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel ?? ProfileViewModel()
		)
	}

	// MARK: - Body

	var body: some View {
		NavigationStack {
			VStack {
				header
				Picker("", selection: $colorScheme.selectedTheme) {
					Text("Тёмная тема").tag(Theme.dark)
					Text("Светлая тема").tag(Theme.light)
				}
				.pickerStyle(.segmented)
				.padding(.top, 18)
				.padding(.horizontal, 16)
				settingsList
			}
			.navigationTitle("Профиль")
			.navigationBarTitleDisplayMode(.large)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
		}
	}
}

// MARK: - UI Components

/// Хедер карточка
private var header: some View {
	NavigationLink {
		ProfileDetail()
	} label: {
		HStack {
			VStack(alignment: .leading) {
				Text("Иванов Иван")
					.font(.mediumCompact(size: 24))
					.foregroundStyle(.black)
				Text("Редактировать профиль")
					.font(.regularCompact(size: 17))
					.foregroundStyle(.black)
			}
			Spacer()
			Image(systemName: "chevron.right")
				.foregroundColor(.black)
				.padding(.trailing, 16)
		}
		.padding(.all)
		.background(.brandYellow)
		.cornerRadius(10)
		.padding(.horizontal)
	}
}

/// Список настроек приложения

private var settingsList: some View {
	List {
		Section {
			NavigationLink {
				TestView()
			} label: {
				Text("Добавить мероприятие")
			}
		}

		Section {
			NavigationLink {
				TestView()
			} label: {
				Text("Уведомления")
			}

			NavigationLink {} label: {
				Text("Помощь и поддержка")
			}
		}

		Section {
			NavigationLink {
				TestView()
			} label: {
				Text("О приложении")
			}
			NavigationLink {
				TestView()
			} label: {
				Text("Оценить")
			}
		}

		Section {
			NavigationLink {
				SignUpView()
			}
			label: {
				Text("Выйти")
					.foregroundStyle(.mainText)
			}
		}
	}
	.scrollDisabled(true)
	.scrollContentBackground(.hidden)
	.listStyle(.insetGrouped)
}

#Preview {
	ProfileView()
}
