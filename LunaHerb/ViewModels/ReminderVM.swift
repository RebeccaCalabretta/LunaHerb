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

    init(repository: ReminderRepository) {
        self.repository = repository
        Task {
            await loadReminders()
        }
    }

    func loadReminders() async {
        reminders = await repository.loadReminders()
    }

    func addReminder(reminder: Reminder) async {
        NotificationManager.shared.scheduleReminderNotification(for: reminder)
        await repository.addReminder(reminder: reminder)
        await loadReminders()
    }

    func removeReminder(by id: UUID) async {
        if let reminder = reminders.first(where: { $0.id == id }) {
            await repository.removeReminder(reminder: reminder)
            await loadReminders()
        }
    }

    func updateReminder(reminder: Reminder) async {
        NotificationManager.shared.scheduleReminderNotification(for: reminder)
        await repository.updateReminder(reminder: reminder)
        await loadReminders()
    }
}
