//
//  EventsRegistationViewModel.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI

final class EventsRegistrationViewModel: ObservableObject {
    @Published var register: Bool
    @Published var isRegistered: Bool = false
    @Published var currentPage: Int = 0
    @Published var name: String = "День ИКН"
    @Published var eventImages: [String] = ["poster"]
    @Published var cheepsTitles: [String] = [
        "12 Cентября", "18:00", "Т-корпус",
    ]
    
    @Published var description: String =
    // swiftlint:disable line_length
        "Дни открытых дверей — это уникальная возможность для старшеклассников больше узнать о специальностях, которым обучают в одном из лучших технических университетов России, научной деятельности под руководством учёных с мировым именем, образовательных проектах и карьерных возможностях, которые предлагает вуз, яркой студенческой жизни в Москве."
    // swiftlint:enable line_length
    
    init(register: Bool) {
        self.register = register
    }
}
