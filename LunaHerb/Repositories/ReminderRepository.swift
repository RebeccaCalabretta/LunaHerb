//
//  ReminderRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 07.03.25.
//

import Foundation
import SwiftData

@MainActor
final class ReminderRepository {
    
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func loadReminders() async throws -> [Reminder] {
        let fetchRequest = FetchDescriptor<Reminder>()
        return try modelContext.fetch(fetchRequest)
    }

    func addReminder(reminder: Reminder) async throws {
        modelContext.insert(reminder)
        try await saveChanges()
    }

    func removeReminder(reminder: Reminder) async throws {
        modelContext.delete(reminder)
        try await saveChanges()
    }

    func updateReminder(reminder: Reminder) async throws {
        try await saveChanges()
    }

    private func saveChanges() async throws {
        try modelContext.save()
    }
}
