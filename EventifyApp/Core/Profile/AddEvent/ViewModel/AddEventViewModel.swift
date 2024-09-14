//
//  AddEventViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import SwiftUI
import PhotosUI

@MainActor
final class AddEventViewModel: ObservableObject {
	@Published var name: String = ""
	@Published var date: Date = .init()
	@Published var startTime: Date = .init()
	@Published var endTime: Date = .init()
	@Published var description: String = ""
	
	@Published private(set) var selectedImages: [UIImage] = []
	@Published var imageSelections: [PhotosPickerItem] = [] {
		didSet {
			setImages(from: imageSelections)
		}
	}

	private func setImages(from selections: [PhotosPickerItem]) {
		Task {
			var images: [UIImage] = []
			
			for selection in selections {
				do {
					let data = try await selection.loadTransferable(type: Data.self)

					guard let data, let uiImage = UIImage(data: data) else {
						throw URLError(.badServerResponse)
					}
					images.append(uiImage)
				} catch {
					print(error)
				}
			}

			selectedImages = images
		}
	}
}
