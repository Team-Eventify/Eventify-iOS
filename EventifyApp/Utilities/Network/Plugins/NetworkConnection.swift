//
//  NetworkConnection.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 06.12.2024.
//

import Foundation
import Network

class NetworkConnection: ObservableObject {
	@Published var isDisconnected = false
	
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue(label: "NetworkManager")
	
	init() {
		monitor.pathUpdateHandler = { [weak self] path in
			DispatchQueue.main.async {
				if path.status == .satisfied {
					self?.isDisconnected = false
				} else {
					self?.isDisconnected = true
				}
			}
		}
		monitor.start(queue: queue)
	}
	
	/// Функция "насильного" обновления `isDisconnected`
	func checkConnection() {
		DispatchQueue.global().async {
			let status = self.monitor.currentPath.status
			DispatchQueue.main.async {
				self.isDisconnected = status != .satisfied
			}
		}
	}
}
