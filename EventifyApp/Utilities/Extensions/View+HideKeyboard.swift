//
//  View+HideKeyboard.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import SwiftUI

extension View {
	func hideKeyboard() {
		let resign = #selector(UIResponder.resignFirstResponder)
		UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
	}
}
