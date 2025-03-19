//
//  ReminderListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var showCreateReminder = false
    @Environment(ReminderVM.self) private var reminderVM
    @State private var editingReminder: Reminder? = nil
    
    var upcomingReminders: [Reminder] {
        reminderVM.reminders.filter { $0.date > Date() }
            .sorted { $0.date < $1.date }
    }
    
    var pastReminders: [Reminder] {
        reminderVM.reminders.filter { $0.date <= Date() }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        List {
            ReminderContent(title: "Bevorstehende Erinnerungen", reminders: upcomingReminders, colorScheme: colorScheme)
            ReminderContent(title: "Vergangene Erinnerungen", reminders: pastReminders, colorScheme: colorScheme)
        }
        .navigationTitle("Erinnerungen")
        .toolbar {
            Button {
                showCreateReminder = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showCreateReminder) {
            CreateReminder(reminder: $editingReminder, defaultDate: Date())
                .presentationDetents([.medium])
        }
        .alert("Fehler", isPresented: Binding(
            get: { reminderVM.errorMessage != nil },
            set: { _ in reminderVM.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            if let errorMessage = reminderVM.errorMessage {
                Text(errorMessage)
            }
        }
        .listStyle(PlainListStyle())
        .globalBackground()
    }
}
