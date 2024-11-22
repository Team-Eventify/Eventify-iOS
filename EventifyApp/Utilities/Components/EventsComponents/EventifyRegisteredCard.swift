//
//  EventifyWaitingEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyRegisteredCard: View {
    let title: String
    let items: [String]
    var isPassed: Bool = false
    var withRateButton = false
    var onRateButtonTap: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .trailing) {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(title)
                                .font(.mediumCompact(size: 17))
                                .foregroundStyle(isPassed ? .black : .mainText)
                                .lineLimit(3)
                                .frame(width: geometry.size.width - 60, alignment: .leading)
                                .frame(height: 45, alignment: .leading)
                            EventifyCheeps(
                                items: items,
                                style: isPassed ? .past : .upcoming
                            )
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 16)
                    
                    Image(isPassed ? "brandLiteralGray" : "brandLiteral")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: .infinity)
                }
                if withRateButton {
                    Spacer(minLength: 0)
                    Button {
                        onRateButtonTap?()
                    } label: {
                        Text("action_rate_app")
                            .font(.mediumCompact(size: 17))
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 42)
                    .background(
                        .accent
                    )
                }
            }
        }
        .frame(height: withRateButton ? 160 : 112)
        .background(isPassed ? .cardsGray : .cards)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    Group {
        EventifyRegisteredCard(
            title: "Семинар по iOS разработке",
            items: ["15 декабря", "10:00", "офлайн"],
            isPassed: false,
            withRateButton: false
        )
        EventifyRegisteredCard(
            title: "День открытых дверей университета МИСИС",
            items: ["12 декабря", "17:30", "онлайн"],
            isPassed: true,
            withRateButton: false
        )
        EventifyRegisteredCard(
            title: "День открытых дверей университета МИСИС",
            items: ["12 декабря", "17:30", "онлайн"],
            isPassed: true,
            withRateButton: true
        )
    }
    .padding(.horizontal, 16)
}
