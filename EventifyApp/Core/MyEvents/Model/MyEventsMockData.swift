//
//  MyEventsMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Мок-данные для экрана "Мои Мероприятия"
enum MyEventsMockData {

    /// Предстоящие мероприятия
    static let upcomingEventsData: [UpcomingEventsModel] = [
        .init(
            title: "Фестиваль ИКН",
            cheepTitles: ["11 сентября", "18:00", "офлайн"]),
        .init(
            title: "ITAM welcome MeetUp",
            cheepTitles: ["14 сентября", "18:30", "онлайн"]),
        .init(
            title: "Wake Up MeetUP",
            cheepTitles: ["26 сентября", "18:00", "Т-корпус"]
        ),
    ]

    /// Рекоммендации мероприятия
    static let recommendedEventsData: [CellsModel] = [
        .init(
            image: "poster", title: "Фестиваль ИКН",
            cheepsItems: ["11 сентября", "18:00", "офлайн"]),
        .init(
            image: "itam", title: "ITAM courses",
            cheepsItems: ["27 сентября", "18:00", "Б-3"]),
    ]
}
