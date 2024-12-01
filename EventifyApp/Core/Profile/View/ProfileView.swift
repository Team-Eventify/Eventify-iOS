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
	
	@StateObject private var viewModel: ProfileViewModel
	@EnvironmentObject private var coordinator: AppCoordinator
	
	init(viewModel: ProfileViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	// MARK: - Body
	
	var body: some View {
		VStack {
			header
			List {
				ForEach(ProfileMenuSection.allCases) { section in
					Section {
						ForEach(section.items) { item in
							makeItemView(for: item)
						}
					}
				}
			}
			.scrollDisabled(true)
			.scrollContentBackground(.hidden)
			.listStyle(.insetGrouped)
		}
		.onAppear {
			viewModel.updateUserInfo()
		}
		.navigationTitle(String(localized: "tab_profile"))
		.navigationBarTitleDisplayMode(.large)
		.background(.bg, ignoresSafeAreaEdges: .all)
	}
	
	/// Хедер карточка
	private var header: some View {
		Button {
			coordinator.push(.profileDetail)
		} label: {
			HStack {
				VStack(alignment: .leading) {
					Text(viewModel.name + " " + viewModel.middleName)
						.font(.mediumCompact(size: 24))
						.foregroundStyle(.black)
					Text("action_edit_profile")
						.font(.regularCompact(size: 17))
						.foregroundStyle(.black)
				}
				Spacer()
				Image(systemName: "chevron.right")
					.foregroundColor(.black)
					.padding(.trailing, 16)
			}
			.padding(.all)
			.background(.brandCyan)
			.cornerRadius(10)
			.padding(.horizontal)
		}
	}
	
	@ViewBuilder
	private func makeItemView(for item: ProfileSectionItem) -> some View {
		switch item {
		case .logout, .deleteAccount:
			Button(LocalizedStringKey(item.titleKey)) {
				handleButtonTap(for: item)
			}
			.foregroundColor(getButtonColor(item))
			.alert(isPresented: alertBinding(for: item)) {
				alert(for: item)
			}
		default:
			Button {
				coordinator.push(item.destination)
			} label: {
				HStack {
					Text(LocalizedStringKey(item.titleKey))
						.foregroundStyle(.mainText)
					Spacer()
					Image(systemName: "chevron.right")
						.foregroundStyle(.mainText)
				}
			}
		}
	}
	
	private func getButtonColor(_ item: ProfileSectionItem) -> Color {
		if case .deleteAccount = item {
			return .red
		}
		return .mainText
	}
	
	private func makeActionForAccountSection(_ item: ProfileSectionItem) {
		if case .logout = item {
			UserDefaultsManager.shared.clearAllUserData()
			coordinator.flow = .auth
			coordinator.authProvider.isLogin = false
			coordinator.selectedTab = .main
			Logger.log(level: .info, "🚪 Exit from account")
		} else {
			UserDefaultsManager.shared.clearAllUserData()
			KeychainManager.shared.clearAll()
			Logger.log(level: .info, "🪓 delete account")
		}
	}
	
	private func alertBinding(for item: ProfileSectionItem) -> Binding<Bool> {
		if case .deleteAccount = item {
			return $viewModel.showingDeleteAlert
		} else {
			return $viewModel.showingExitAlert
		}
	}
	
	private func handleButtonTap(for item: ProfileSectionItem) {
		if case .deleteAccount = item {
			viewModel.showingDeleteAlert = true
		} else {
			viewModel.showingExitAlert = true
		}
	}
	
	private func alert(for item: ProfileSectionItem) -> Alert {
		Alert(
			title: Text(LocalizedStringKey(item.alertTitleKey ?? "")),
			primaryButton: .cancel(Text(String(localized: "common_no"))),
			secondaryButton: .destructive(
				Text(String(localized: "common_yes")),
				action: {
					makeActionForAccountSection(item)
				}
			)
		)
	}
}
