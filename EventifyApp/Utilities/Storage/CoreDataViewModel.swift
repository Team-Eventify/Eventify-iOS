//
//  StorageProvider.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 22.11.2024.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
	let container: NSPersistentContainer
	@Published var savedEvents: [EventEntity] = []

	init() {
		container = NSPersistentContainer(name: "EventsContainer")
		
		container.loadPersistentStores { _, error in
			if let error {
				Logger.log(level: .error(error), "Error loading Core Data store")
			} else {
				Logger.log(level: .database, "Succeeded to load Core Data store")
			}
		}

		fetchEvents()
	}

	func fetchEvents() {
		let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
		
		do {
			savedEvents = try container.viewContext.fetch(request)
		} catch {
			Logger.log(level: .error(error), "Error fetching events")
		}
	}
	
	func addEvent(text: String) {
		let newEvent = EventEntity(context: container.viewContext)
		newEvent.name = text
		saveData()
	}
	
	func saveData() {
		do {
			try container.viewContext.save()
			fetchEvents()
		} catch let error {
			Logger.log(level: .error(error), "Error saving data")
		}
	}
}
