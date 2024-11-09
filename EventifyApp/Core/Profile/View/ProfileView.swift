//
//  Profile.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import PulseUI
import SwiftUI

enum ProfileSectionItem: Identifiable {
	case addEvent
	case pulseConsole
	case notifications
	case helpAndSupport
	case aboutApp
	case rateApp
	case logout
	case deleteAccount

	var id: String { titleKey }

	var titleKey: String {
		switch self {
		case .addEvent:
			"action_add_event"
		case .pulseConsole:
			"Pulse_console"
		case .notifications:
			"section_notifications"
		case .helpAndSupport:
			"section_help_support"
		case .aboutApp:
			"section_about_app"
		case .rateApp:
			"action_rate_app"
		case .logout:
			"action_logout"
		case .deleteAccount:
			"action_delete_account"
		}
	}

	@ViewBuilder
	var destination: some View {
		switch self {
		case .addEvent:
			AddEventView()
		case .pulseConsole:
			ConsoleView()
				.closeButtonHidden()
		case .notifications, .helpAndSupport, .aboutApp, .rateApp:
			TestView()
		default: EmptyView()
		}
	}

	var isDestructive: Bool {
		self == .logout || self == .deleteAccount
	}

	var alertTitleKey: String? {
		switch self {
		case .logout:
			"alert_logout_confirmation"
		case .deleteAccount:
			"alert_delete_account_confirmation"
		default: nil
		}
	}
}

enum ProfileMenuSection: Int, Identifiable, CaseIterable {
	case main
	case options
	case about
	case account

	var id: Int { rawValue }
	var items: [ProfileSectionItem] {
		switch self {
		case .main:
			return [.addEvent]
		case .options:
			return [.pulseConsole, .notifications, .helpAndSupport]
		case .about:
			return [.aboutApp, .rateApp]
		case .account:
			return [.logout, .deleteAccount]
		}
	}
}

/// Вью экрана "Профиль"
struct ProfileView: View {
	// MARK: - Private Properties

	@StateObject private var viewModel: ProfileViewModel
	@State var showingDeleteAlert: Bool = false
	@State var showingExitAlert: Bool = false
	@State var navigateToSignUp: Bool = false

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter viewModel: модель экрана профиля
	init(viewModel: ProfileViewModel? = nil) {
		_viewModel = StateObject(
			wrappedValue: viewModel
				?? ProfileViewModel(userService: UserService())
		)
	}

	// MARK: - Body

	var body: some View {
		NavigationStack {
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
	}

	/// Хедер карточка
	private var header: some View {
		NavigationLink {
			ProfileDetailView()
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
			NavigationLink(destination: item.destination) {
				Text(LocalizedStringKey(item.titleKey))
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
			Constants.isLogin = false
			UserDefaultsManager.shared.clearAllUserData()
			KeychainManager.shared.clearAll()
			Logger.log(level: .info, "🚪 Exit from account")
		} else {
			Constants.isLogin = false
			UserDefaultsManager.shared.clearAllUserData()
			Logger.log(level: .info, "🪓 delete account")
		}
	}

	private func alertBinding(for item: ProfileSectionItem) -> Binding<Bool> {
		if case .deleteAccount = item {
			return $showingDeleteAlert
		} else {
			return $showingExitAlert
		}
	}

	private func handleButtonTap(for item: ProfileSectionItem) {
		if case .deleteAccount = item {
			showingDeleteAlert = true
		} else {
			showingExitAlert = true
		}
	}

	// TODO: сделать кастом алерт
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

#Preview {
	ProfileView()
}
