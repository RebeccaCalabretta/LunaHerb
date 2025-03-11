//
//  ReminderRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 07.03.25.
//

import Foundation
import SwiftData

final class ReminderRepository {
    
    var errorMessage: String?
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func loadReminders() async -> [Reminder] {
        do {
            let fetchRequest = FetchDescriptor<Reminder>()
            let reminders = try modelContext.fetch(fetchRequest)
            return reminders
        } catch {
            errorMessage = error.localizedDescription
            return []
        }
    }

    func addReminder(reminder: Reminder) async {
        modelContext.insert(reminder)
        await saveChanges()
    }

    func removeReminder(reminder: Reminder) async {
        modelContext.delete(reminder)
        await saveChanges()
    }

    func updateReminder(reminder: Reminder) async {
        await saveChanges()
    }

    private func saveChanges() async {
        do {
            try modelContext.save()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
