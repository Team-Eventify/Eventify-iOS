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
    @Published var shouldDismiss: Bool = false
    @Published var showPopUp: Bool = false
	@Published var imageSelections: [PhotosPickerItem] = [] {
		didSet {
			setImages(from: imageSelections)
		}
	}
    
    private let eventService: EventsServiceProtocol
    
    // MARK: - Initialization
    
    /// Инициализатор
    /// - Parameter eventService: сервис для отправки ивентов на бэк
    init(eventService: EventsServiceProtocol) {
        self.eventService = eventService
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
    
    func sendEvent() {
        
        guard name.isEmpty, description.isEmpty else {
            return
        }
        
        let ownerID = KeychainManager.shared.get(key: KeychainKeys.userId)
        
        let json: JSON = [
            "title": name,
            "description": description,
            "start": Int(startTime.timeIntervalSince1970),
            "end": Int(endTime.timeIntervalSince1970),
            "ownerID": ownerID ?? "no id"
        ]
        
        Task { @MainActor in
            do {
                let response = try await eventService.newEvent(json: json)
                print(response)
                shouldDismiss = true
            } catch {
                showPopUp = true
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
