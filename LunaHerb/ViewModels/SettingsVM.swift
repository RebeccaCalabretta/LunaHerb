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
    private let repository: ReminderRepository
    
    init(repository: ReminderRepository) {
        self.repository = repository
        applyDarkMode(isDarkModeEnabled)
    }

    var isDarkModeEnabled: Bool {
        get { defaults.bool(forKey: "darkMode") }
        set {
            defaults.set(newValue, forKey: "darkMode")
            applyDarkMode(newValue)
        }
    }

    func applyDarkMode(_ enabled: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = enabled ? .dark : .light
            }
        }
    }

    func rescheduleAllReminders() async {
        do {
            let reminders = try await repository.loadReminders()
            await NotificationManager.shared.rescheduleAllNotifications(for: reminders)
        } catch {
            print("❌ Fehler beim Neuladen der Erinnerungen: \(error.localizedDescription)")
        }
    }
}
