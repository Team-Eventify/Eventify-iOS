//
//  Profile.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.07.2024.
//

import SwiftUI
import PulseUI
import PopupView

/// Вью экрана "Профиль"
struct ProfileView: View {
	// MARK: - Private Properties

    @StateObject private var viewModel: ProfileViewModel
	@EnvironmentObject private var networkManager: NetworkManager

	// MARK: - Initialization

	/// Инициализатор
	/// - Parameter viewModel: модель экрана профиля
    init(viewModel: ProfileViewModel? = nil) {
		_viewModel = StateObject(
            wrappedValue: viewModel ?? ProfileViewModel(userService: UserService())
		)
	}

	// MARK: - Body

	var body: some View {
		NavigationStack {
			VStack {
				header
				List {
					Section {
						NavigationLink {
							AddEventView()
						} label: {
                            Text("action_add_event")
						}
					}

					Section {
						NavigationLink(destination: ConsoleView()) {
							Text("Pulse Консоль")
						}
						
						NavigationLink {
							TestView()
						} label: {
                            Text("section_notifications")
						}

						NavigationLink {
                            TestView()
                        } label: {
                            Text("section_help_support")
						}
					}

					Section {
						NavigationLink {
							TestView()
						} label: {
                            Text("section_about_app")
						}
						NavigationLink {
							TestView()
						} label: {
                            Text("action_rate_app")
						}
					}

					Section {
						Button {
							viewModel.showingExitAlert = true
						} label: {
                            Text("action_logout")
								.foregroundStyle(.mainText)
						}
						.alert(String(localized: "alert_logout_confirmation"), isPresented: $viewModel.showingExitAlert) {
							Button(role: .cancel) {
								Constants.isLogin = false
                                UserDefaultsManager.shared.clearAllUserData()
                                KeychainManager.shared.clearAll()
                                Log.info("🚪 Exit from account")
							} label: {
                                Text("common_yes")
									.foregroundStyle(.error)
							}

							Button {
								print("Continue work in app")
							} label: {
                                Text("common_no")
									.foregroundStyle(.mainText)
							}
						}
						Button {
							viewModel.showingDeleteAlert = true
						} label: {
                            Text("action_delete_account")
								.foregroundStyle(.error)
						}
						.alert(String(localized: "alert_delete_account_confirmation"), isPresented: $viewModel.showingDeleteAlert) {

							Button(role: .cancel) {
								Constants.isLogin = false
                                UserDefaultsManager.shared.clearAllUserData()
                                Log.info("🪓 delete account")
							} label: {
                                Text("common_yes")
									.foregroundStyle(.error)
							}

							Button {
                                Log.info("✏️ resume account")
							} label: {
                                Text("common_no")
									.foregroundStyle(.mainText)
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
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.bg, ignoresSafeAreaEdges: .all)
			.popup(isPresented: $networkManager.isDisconnected) {
				InternetErrorToast()
			} customize: {
				$0.type(.toast)
					.disappearTo(.topSlide)
					.position(.top)
					.isOpaque(true)
			}
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
}

#Preview {
	ProfileView()
		.environmentObject(NetworkManager())
}
