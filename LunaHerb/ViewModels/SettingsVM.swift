//
//  SettingsVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation
import SwiftData
import UIKit

@Observable
final class SettingsVM {
    private let defaults = UserDefaults.standard

    var isDarkModeEnabled: Bool {
        get { defaults.bool(forKey: "darkMode") }
        set {
            defaults.set(newValue, forKey: "darkMode")
            applyDarkMode(newValue)
        }
    }
    
    func applyDarkMode(_ enabled: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = enabled ? .dark : .light
            }
        }
    }
    
    init() {
        applyDarkMode(isDarkModeEnabled)
    }
}
