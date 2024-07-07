//
//  CategoriesModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct CategoriesModel: Identifiable {
	let id = UUID()
	let title: String
	let image: String
	let color: Color
}
