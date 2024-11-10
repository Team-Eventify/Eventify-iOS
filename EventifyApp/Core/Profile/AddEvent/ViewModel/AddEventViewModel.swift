//
//  AddEventViewModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import PhotosUI
import SwiftUI

final class AddEventViewModel: ObservableObject {
	@Published var name: String = ""
	@Published var date: Date = .init()
	@Published var startTime: Date = .init()
	@Published var endTime: Date = .init()
	@Published var description: String = ""
	@Published private(set) var selectedImages: [UIImage] = []
	@Published var shouldDismiss: Bool = false
	@Published var showPopUp: Bool = false
	@Published var isError: Bool = false
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
		Task { @MainActor in
			var images: [UIImage] = []

			for selection in selections {
				do {
					let data = try await selection.loadTransferable(
						type: Data.self)

					guard let data, let uiImage = UIImage(data: data) else {
						throw URLError(.badServerResponse)
					}
					images.append(uiImage)
				} catch {
					Logger.log(level: .error(error), "")
				}
			}

			selectedImages = images
		}
	}

	/// Отправляет событие на сервер после проверки заполненности всех обязательных полей.
	///
	/// Если одно из обязательных полей (`name`, `description`, `imageSelections`) пустое, анимация ошибки активируется
	/// на 1.5 секунды, после чего будет отключена. Если все поля заполнены, отправляется запрос на сервер для создания нового события.
	///
	/// - Примечание: В случае успешной отправки, экран автоматически закрывается, изменяя состояние `shouldDismiss`.
	/// - Примечание: В случае ошибки при отправке события, показывается всплывающее уведомление (`showPopUp`).
	///
	/// - Throws: Функция может выбросить ошибку, если что-то пойдет не так при отправке запроса на сервер.
	func sendEvent() async {

		guard !name.isEmpty, !description.isEmpty, !imageSelections.isEmpty
		else {
			withAnimation {
				isError = true
			}

			try? await Task.sleep(nanoseconds: 1_500_000_000)

			withAnimation {
				isError = false
			}

			return
		}

		let ownerID = KeychainManager.shared.get(key: KeychainKeys.userId)

		let json: JSON = [
			"title": name,
			"description": description,
			"start": Int(startTime.timeIntervalSince1970),
			"end": Int(endTime.timeIntervalSince1970),
			"ownerID": ownerID ?? "no id",
		]

		Task { @MainActor in
			do {
				let response = try await eventService.newEvent(json: json)
				Logger.log(level: .info, "\(response)")
				shouldDismiss = true
			} catch {
				showPopUp = true
				Logger.log(level: .error(error), "")
			}
		}
	}
}
