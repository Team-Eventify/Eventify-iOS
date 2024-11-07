//
//  ValidationRow.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.11.2024.
//

import SwiftUI

struct ValidationRow: View {
	var rule: ValidationRule

	private var foregroundColor: Color {
		rule.isValid ? Color.green : Color.gray
	}

	var body: some View {
		HStack {
			rule.correctIcon
				.foregroundColor(foregroundColor)

			Text(rule.description)
				.foregroundStyle(Color.secondaryText)
				.font(.regularCompact(size: 14))
		}
	}
}
