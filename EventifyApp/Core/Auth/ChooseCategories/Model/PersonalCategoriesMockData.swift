//
//  PersonalCategoriesMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.08.2024.
//

import Foundation

enum PersonalCategoriesMockData {
	static let categories: [[PersonalCategories]] = [
		[
			.init(name: "Наука", selectionColor: .red),
			.init(name: "Спорт", selectionColor: .blue),
			.init(name: "Творчество", selectionColor: .green)
		],
		[
			.init(name: "Дизайн", selectionColor: .yellow),
			.init(name: "Frontend", selectionColor: .orange),
			.init(name: "Mobile", selectionColor: .purple),
		],
		[
			.init(name: "Backend", selectionColor: .pink),
			.init(name: "ML", selectionColor: .gray),
			.init(name: "GameDev", selectionColor: .brown),
			.init(name: "Media", selectionColor: .cyan),
		],
		[
			.init(name: "Аналитика", selectionColor: .indigo),
			.init(name: "Хакатоны", selectionColor: .mint),
			.init(name: "Театр", selectionColor: .teal)
		],
		[
			.init(name: "Наставничество", selectionColor: .science),
			.init(name: "Студенческая жизнь", selectionColor: .sport),
		],
	]
}
