//
//  PageControl.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 04.09.2024.
//

import SwiftUI

struct PageControl: View {
	let numberOfPages: Int
	@Binding var currentPage: Int

	var body: some View {
		HStack {
			ForEach(0..<numberOfPages, id: \.self) { page in
				Circle()
					.fill(page == currentPage ? .mainText : .gray)
					.frame(width: 8, height: 8)
			}
		}
	}
}
