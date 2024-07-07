//
//  setBorder.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 15.06.2024.
//

import SwiftUI

struct SetBorderModifier: ViewModifier {
	var width: CGFloat
	var color: Color
	var radius: CGFloat

	func body(content: Content) -> some View {
		content
			.overlay {
				RoundedRectangle(cornerRadius: radius)
					.stroke(color, lineWidth: width)
			}
	}
}

extension View {
	func setBorder(width: CGFloat, color: Color, radius: CGFloat) -> some View {
		self.modifier(SetBorderModifier(width: width, color: color, radius: radius))
	}
}
