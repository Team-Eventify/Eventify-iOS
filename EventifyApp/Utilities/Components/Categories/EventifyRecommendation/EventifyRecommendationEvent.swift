//
//  EventifyRecommendationEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

/// Вью ячейки организаторов
struct EventifyRecommendationEvent: View {
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
    
    private var isFlexible: Bool {
        return size == .flexible
    }
    
    /// Инициализирует `EventifyRecommendationEvent` с изображением, заголовком, описанием, элементами и размером.
    init(image: String, title: String, description: String? = nil, cheepsItems: [String], size: EventCellSize) {
        self.image = image
        self.title = title
        self.description = description
        self.cheepsItems = cheepsItems
        self.size = size
    }

    var body: some View {
        VStack(alignment: .leading, spacing: isFlexible ? 8 : 16) {
			Image(image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(
                    width: size.width,
                    height: isFlexible ? nil : size.height! / 2
                )
				.clipped()
            contentWithPadding
            Spacer()
		}
		.frame(width: size.width, height: size.height)
        .background(isFlexible ? .bg : .cards)
		.clipShape(.rect(cornerRadius: 10))
    }
    
    private var contentWithPadding: some View {
        VStack(alignment: .leading, spacing: isFlexible ? 8 : 16) {
            Text(title)
                .font(.mediumCompact(size: isFlexible ? 20 : 14))
                .foregroundStyle(.mainText)
            descriptionView
            EventifyCheeps(items: cheepsItems, style: .common, fontSize: isFlexible ? 16 : 12)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, isFlexible ? 0 : 16)
    }
    
    @ViewBuilder
    private var cheepsView: some View {
        if isFlexible {
            EventifyCheeps(items: cheepsItems, style: .common)
                .padding(.bottom, 16)
        } else {
            EventifyCheeps(items: cheepsItems, style: .common)
                .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if description != nil {
            VStack(alignment: .leading) {
                Text(description!)
                    .font(.mediumCompact(size: 17))
                    .foregroundStyle(.mainText)
            }
        }
    }
}

#Preview {
	EventifyRecommendationEvent(
		image: "recomm",
		title: "День открытых дверей университета МИСИС",
		cheepsItems: ["12 декабря", "17:30", "онлайн"],
        size: .slim
	)
		.padding(.horizontal, 16)
}
