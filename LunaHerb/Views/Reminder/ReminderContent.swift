//
//  ReminderContent.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.03.25.
//

import SwiftUI

struct ReminderContent: View {
    let title: String
    let reminders: [Reminder]
    let colorScheme: ColorScheme
    @Environment(ReminderVM.self) private var reminderVM
    
    var body: some View {
        Section(title) {
            ForEach(reminders) { reminder in
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
}

