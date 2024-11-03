//
//  EventifyAppApp.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.06.2024.
//

import SwiftUI
import TelemetryDeck

@main
struct EventifyApp: App {
    init() {
        let config = TelemetryDeck.Config(appID: "0A2CAECB-DB4D-4493-849B-CC097DF06552")
        TelemetryDeck.initialize(config: config)
        TelemetryDeck.signal("App.launched")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
