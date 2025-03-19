//
//  ReminderVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import Foundation

@Observable
final class ReminderVM {
    
    private let repository: ReminderRepository
    var reminders: [Reminder] = []
    var errorMessage: String?

    init(repository: ReminderRepository) {
        self.repository = repository
        Task {
            await loadReminders()
        }
    }

    func loadReminders() async {
        do {
            reminders = try await repository.loadReminders()
        } catch {
            errorMessage = "Fehler beim Laden der Erinnerungen: \(error.localizedDescription)"
        }
    }

    func addReminder(reminder: Reminder) async {
        do {
            NotificationManager.shared.scheduleReminderNotification(for: reminder)
            try await repository.addReminder(reminder: reminder)
            await loadReminders()
        } catch {
            errorMessage = "Fehler beim Speichern der Erinnerung: \(error.localizedDescription)"
        }
    }

    func removeReminder(by id: UUID) async {
        do {
            await NotificationManager.shared.removePendingNotification(for: id)
            if let reminder = reminders.first(where: { $0.id == id }) {
                try await repository.removeReminder(reminder: reminder)
                await loadReminders()
            }
        } catch {
            errorMessage = "Fehler beim Löschen der Erinnerung: \(error.localizedDescription)"
        }
    }

    func updateReminder(reminder: Reminder) async {
        do {
            await NotificationManager.shared.removePendingNotification(for: reminder.id)
            try await repository.updateReminder(reminder: reminder)
            NotificationManager.shared.scheduleReminderNotification(for: reminder)
            await loadReminders()
        } catch {
            errorMessage = "Fehler beim Aktualisieren der Erinnerung: \(error.localizedDescription)"
        }
    }
}
