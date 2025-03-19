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
    
    var body: some View {
        List {
            Section("Bevorstehende Erinnerungen") {
                ForEach(reminderVM.reminders.filter { $0.date > Date() }
                    .sorted { $0.date < $1.date }) { reminder in
                        ReminderSectionView(reminder: reminder, colorScheme: colorScheme)
                            .swipeActions {
                                Button(role: .destructive) {
                                    Task {
                                        await reminderVM.removeReminder(by: reminder.id)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color("cancelActions"))
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
            }
            Section("Vergangene Erinnerungen") {
                ForEach(reminderVM.reminders.filter { $0.date <= Date() }
                    .sorted { $0.date > $1.date }) { reminder in
                        ReminderSectionView(reminder: reminder, colorScheme: colorScheme)
                            .swipeActions {
                                Button(role: .destructive) {
                                    Task {
                                        await reminderVM.removeReminder(by: reminder.id)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color("cancelActions"))
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
            }
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
            CreateReminder(reminder: $editingReminder)
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
