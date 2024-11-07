//
//  NetworkManager.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.11.2024.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
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
}
