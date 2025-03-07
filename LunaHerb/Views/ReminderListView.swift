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
    @Environment(ReminderVM.self) private var viewModel
    @State private var editingReminder: Reminder? = nil
    
    var body: some View {
        List {
            Section("Bevorstehende Erinnerungen") {
                ForEach(viewModel.reminders.filter { $0.date > Date() }
                    .sorted { $0.date < $1.date }) { reminder in
                        ReminderSectionView(reminder: reminder, colorScheme: colorScheme)
                            .swipeActions {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.removeReminder(by: reminder.id)
                                    }
                                } label: {
                                    Label("Löschen", systemImage: "trash")
                                }
                                .tint(Color("cancelActions"))
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
            }
            Section("Vergangene Erinnerungen") {
                ForEach(viewModel.reminders.filter { $0.date <= Date() }
                    .sorted { $0.date > $1.date }) { reminder in
                        ReminderSectionView(reminder: reminder, colorScheme: colorScheme)
                            .swipeActions {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.removeReminder(by: reminder.id)
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
        .listStyle(PlainListStyle())
        .globalBackground()
    }
}


