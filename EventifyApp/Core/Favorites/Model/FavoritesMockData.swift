//
//  FavoritesMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.07.2024.
//

import Foundation

/// Мок-дынные для экрана "Избранное"
enum FavoritesMockData {

    /// Избранные мероприятия
    static let eventsData: [CellsModel] = [
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "event2", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
    ]

    /// Рекомендуемые меропрития
    static let recomendedEventsData: [CellsModel] = [
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "event2", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
        .init(
            image: "recomm", title: "День открытых дверей университета МИСИС",
            cheepsItems: ["12 декабря", "17:30", "онлайн"]),
    ]

    static let organizatorsData: [CellsModel] = [
        .init(
            image: "itam", title: "ITAM",
            cheepsItems: ["backend", "frontend", "design", "mobile"]),
        .init(
            image: "itam", title: "ITAM",
            cheepsItems: ["backend", "frontend", "design", "mobile"]),
        .init(
            image: "itam", title: "ITAM",
            cheepsItems: ["backend", "frontend", "design", "mobile"]),
        .init(
            image: "itam", title: "ITAM",
            cheepsItems: ["backend", "frontend", "design", "mobile"]),
    ]
}
