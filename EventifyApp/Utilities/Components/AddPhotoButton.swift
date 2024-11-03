//
//  AddPhotoButton.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import SwiftUI
import PhotosUI

/// кнопка добавления фото
struct AddPhotoButton: View {
	@Binding var pickerItem: [PhotosPickerItem]
	var body: some View {
		PhotosPicker(selection: $pickerItem, maxSelectionCount: 5, matching: .images) {
			Image(systemName: "plus")
				.font(.regularCompact(size: 50))
				.foregroundColor(.mainText)
				.frame(width: 100, height: 100)
				.background(.cards)
				.cornerRadius(8)
		}
	}
}
