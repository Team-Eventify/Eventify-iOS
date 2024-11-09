//
//  EventifyCategories.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 06.07.2024.
//

import SwiftUI

struct CategoriesConfiguration {
    let text: String
    let image: String
    let color: Color
}

struct EventifyCategories: View {
    let configuration: CategoriesConfiguration

    var body: some View {
        ZStack {
            HStack(spacing: .zero) {
                Spacer()
                Image(configuration.image)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(configuration.color)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(alignment: .topLeading) {
            Text(configuration.text)
                .font(.mediumCompact(size: 24))
                .foregroundColor(.black)
                .padding([.leading, .top], 16)
        }
    }
}

#Preview {
    EventifyCategories(
        configuration: .init(
            text: "Спорт",
            image: "sport",
            color: .sport
        )
    )
    .padding(.horizontal, 16)
}
