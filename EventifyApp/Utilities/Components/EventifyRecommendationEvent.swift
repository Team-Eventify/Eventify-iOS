//
//  EventifyRecommendationEvent.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 07.07.2024.
//

import SwiftUI

struct EventifyRecommendationEvent: View {
    var body: some View {
		VStack(alignment: .leading,spacing: 16) {
			Image("recomm")
			Text("День открытых дверей университета МИСИС")
				.font(.mediumCompact(size: 14))
				.foregroundStyle(.mainText)
		}
		.frame(maxWidth: .infinity)
		.frame(width: 235, height: 278)
		.background(.bg)
		.clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    EventifyRecommendationEvent()
		.padding(.horizontal, 16)
}
