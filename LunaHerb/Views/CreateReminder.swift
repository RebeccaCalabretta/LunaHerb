//
//  CreateReminder.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import SwiftUI

struct CreateReminder: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ReminderVM.self) private var viewModel
    @State private var message: String = ""
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Erinnerung")) {
                    TextField("Nachricht eingeben", text: $message)
                }
                
                Section {
                    HStack {
                        Text("Zeitpunkt wählen")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        Spacer()
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.blue.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Speichern") {
                        viewModel.addReminder(message: message, date: selectedDate)
                        dismiss()
                    }
                    .disabled(message.isEmpty)
                }
            }
        }
    }
}
