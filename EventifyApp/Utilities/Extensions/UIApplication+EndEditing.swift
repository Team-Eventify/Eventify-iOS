//
//  EndEditing+UIApplication.swift
//  EventifyApp
//
//  Created by Станислав Никулин on 14.11.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
