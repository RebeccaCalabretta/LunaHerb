//
//  MoonDatePicker.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 13.03.25.
//

import SwiftUI

struct MoonDatePicker: View {
    @Binding var selectedDate: Date
    var colorScheme: ColorScheme

    var body: some View {
        DatePicker("Datum", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .labelsHidden()
            .padding()
            .frame(width: 160)
            .gradientBackground()
            .clipShape(Capsule())
            .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.4), radius: 2, x: 2, y: 2)
    }
}
