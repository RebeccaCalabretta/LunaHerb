//
//  ReminderVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import Foundation

@Observable
final class ReminderVM {
    
    var reminders: [Reminder] = []
    
    func addReminder(message: String, date: Date) {
        let newReminder = Reminder(message: message, date: date)
        reminders.append(newReminder)
    }
    
    func removeReminder(by id: UUID) {
        if let index = reminders.firstIndex(where: { $0.id == id }) {
            reminders.remove(at: index)
        }
    }
}



