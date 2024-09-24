//
//  ProfileViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.07.2024.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
	// MARK: - Public Properties
	
    @AppStorage("isLogin") var isLogin: Bool = false
    @Published var name: String = ""
    @Published var surname: String = ""

	@Published var selectedPicker: Int = 0 {
		didSet {
			if selectedPicker == 0 {
				AppColorScheme.shared.colorScheme = .dark
			} else {
				AppColorScheme.shared.colorScheme = .light
			}
		}
	}
    
    func updateUserInfo() {
        name = UserDefaultsManager.shared.getFirstName() ?? "Имя"
        surname = UserDefaultsManager.shared.getMiddleName() ?? "Фамилия"
    }
}
