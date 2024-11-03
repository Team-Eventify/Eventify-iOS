//
//  Binding+Unwrapped.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 08.10.2024.
//

import SwiftUI

extension Binding {
    func unwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}
