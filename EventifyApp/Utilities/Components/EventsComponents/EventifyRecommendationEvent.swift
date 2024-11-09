//
//  EventifyRecommendationEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct RecommendationEventConfiguration {
    /// Изображение для события.
    let image: String
    /// Заголовок события.
    let title: String
    /// Описание события.
    let description: String?
    /// Элементы для отображения (например, дата, время, формат).
    let cheepsItems: [String]
    /// Размер ячейки события.
    let size: EventCellSize

    init(
        image: String,
        title: String,
        description: String? = nil,
        cheepsItems: [String],
        size: EventCellSize
    ) {
        self.image = image
        self.title = title
        self.description = description
        self.cheepsItems = cheepsItems
        self.size = size
    }

    var isFlexible: Bool {
        return size == .flexible
    }
}

/// Вью ячейки организаторов
struct EventifyRecommendationEvent: View {
    let configuration: RecommendationEventConfiguration
    
    /// Инициализирует `EventifyRecommendationEvent` с изображением, заголовком, описанием, элементами и размером.
    init(configuration: RecommendationEventConfiguration) {
        self.configuration = configuration
    }

    var body: some View {
        VStack(alignment: .leading, spacing: configuration.isFlexible ? 8 : 16) {
            Image(configuration.image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(
                    width: configuration.size.width,
                    height: configuration.isFlexible ? 200 : (configuration.size.height ?? 0) / 2
                )
				.clipped()
            contentWithPadding
            Spacer()
		}
        .frame(width: configuration.size.width, height: configuration.size.height)
        .background(configuration.isFlexible ? .bg : .cards)
		.clipShape(.rect(cornerRadius: 10))
    }
    
    private var contentWithPadding: some View {
        VStack(alignment: .leading, spacing: configuration.isFlexible ? 8 : 16) {
            Text(configuration.title)
                .font(.mediumCompact(size: configuration.isFlexible ? 20 : 14))
                .foregroundStyle(.mainText)
            descriptionView
            EventifyCheeps(
                items: configuration.cheepsItems,
                style: .common,
                fontSize: configuration.isFlexible ? 16 : 12
            )
            .padding(.bottom, 16)
        }
        .padding(.horizontal, configuration.isFlexible ? 0 : 16)
    }
    
    @ViewBuilder
    private var cheepsView: some View {
        if configuration.isFlexible {
            EventifyCheeps(items: configuration.cheepsItems, style: .common)
                .padding(.bottom, 16)
        } else {
            EventifyCheeps(items: configuration.cheepsItems, style: .common)
                .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if let description = configuration.description {
            VStack(alignment: .leading) {
                Text(description)
                    .font(.regularCompact(size: 17))
                    .foregroundStyle(.mainText)
            }
        }
    }
}

#Preview {
    EventifyRecommendationEvent(
        configuration: RecommendationEventConfiguration(
            image: "recomm",
            title: "День открытых дверей университета МИСИС",
            cheepsItems: [],
            size: .slim
        )
    )
    .padding(.horizontal, 16)
}
