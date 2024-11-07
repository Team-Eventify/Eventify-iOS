//
//  InternetErrorToast.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.11.2024.
//

import SwiftUI

struct InternetErrorToast: View {
    var body: some View {
		VStack(spacing: 0) {
			Text("Нет соединения с интернетом.")
			Text("Проверьте подключение.")
		}
		.font(.regularCompact(size: 16))
		.foregroundStyle(.black)
		.padding(EdgeInsets(top: 60, leading: 32, bottom: 16, trailing: 32))
		.frame(maxWidth: .infinity)
		.background(.error)
    }
}

#Preview {
    InternetErrorToast()
}
