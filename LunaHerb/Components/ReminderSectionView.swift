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

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(reminder.date, style: .date)
                .font(.headline)
                .foregroundStyle(Color("favorableTitle"))
            Text(reminder.message)
           
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sectionBackground(colorScheme: colorScheme)
    }
}

#Preview {
    ReminderSectionView(reminder: Reminder(
        id: UUID(),
        message: "Heute vormittags Bärlauch sammeln!",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 5, hour: 10, minute: 0)) ?? Date()
    ), colorScheme: .light)
}
