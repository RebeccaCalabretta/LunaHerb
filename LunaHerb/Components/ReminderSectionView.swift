//
//  ReminderSectionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import SwiftUI

struct ReminderSectionView: View {
    var reminder: Reminder
    let colorScheme: ColorScheme
    @State private var showEditMode = false
    @State private var editingReminder: Reminder?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(reminder.date, style: .date)
                    .font(.headline)
                    .foregroundStyle(Color("favorableTitle"))
                Text(reminder.message)
            }
            Button(action: {
                editingReminder = reminder
                showEditMode = true
            }) {
                Image(systemName: "pencil")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .trailing)        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sectionBackground(colorScheme: colorScheme)
        .sheet(item: $editingReminder) { editingReminder in
            CreateReminder(reminder: $editingReminder)
        }
    }
}

#Preview {
    ReminderSectionView(reminder: Reminder(
        id: UUID(),
        message: "Heute vormittags Bärlauch sammeln!",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 5, hour: 10, minute: 0)) ?? Date()
    ), colorScheme: .light)
}
