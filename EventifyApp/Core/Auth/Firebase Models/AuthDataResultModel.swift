//
//  AuthDataResultModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
	let uid: String
	let email: String?

	init(user: User) {
		self.uid = user.uid
		self.email = user.email
	}
}
