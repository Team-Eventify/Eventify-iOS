//
//  EventifyWaitingEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyUpcomingEvent: View {
    let title: String
    let items: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(title)
                            .font(.mediumCompact(size: 17))
                            .foregroundStyle(.mainText)
                            .lineLimit(3)
                            .frame(width: geometry.size.width - 60, alignment: .leading)
                            .frame(height: 45, alignment: .leading)
                        EventifyCheeps(items: items, style: .upcoming)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 16)
                
                Image("brandLiteral")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(height: 112)
        .background(.cards)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    EventifyUpcomingEvent(
        title: "День открытых дверей университета МИСИС",
        items: ["12 декабря", "17:30", "онлайн"]
    )
        .padding(.horizontal, 16)
}