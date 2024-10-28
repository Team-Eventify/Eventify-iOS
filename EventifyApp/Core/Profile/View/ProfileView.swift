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
	@State var showingDeleteAlert: Bool = false
	@State var showingExitAlert: Bool = false
	@State var navigateToSignUp: Bool = false

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
							showingExitAlert.toggle()
						} label: {
                            Text("action_logout")
								.foregroundStyle(.mainText)
						}
						.alert("Вы действительно хотите выйти из приложения?", isPresented: $showingExitAlert) {
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
							showingDeleteAlert.toggle()
						} label: {
                            Text("action_delete_account")
								.foregroundStyle(.error)
						}
                        .alert(NSLocalizedString("alert_delete_account_confirmation", comment: "Удалить информацию об аккаунте"), isPresented: $showingDeleteAlert) {

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
            
            .navigationTitle(NSLocalizedString("tab_profile", comment: "Профиль"))
			.navigationBarTitleDisplayMode(.large)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
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
}

#Preview {
	ProfileView()
}
