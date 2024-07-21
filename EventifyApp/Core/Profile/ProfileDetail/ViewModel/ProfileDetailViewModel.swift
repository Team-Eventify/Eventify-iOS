//
//  ProfileDetailViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 20.07.2024.
//

import SwiftUI

@MainActor
final class ProfileDetailViewModel: ObservableObject {
	// MARK: - Public Properties

	@Published var name: String = ""
	@Published var surname: String = ""
	@Published var email: String = ""
	@Published var telegram: String = ""
}
