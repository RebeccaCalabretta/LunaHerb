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
    @Binding var reminder: Reminder?
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Erinnerung")) {
                    TextField("Nachricht eingeben", text: $message)
                        .onAppear {
                            if let reminder = reminder {
                                self.message = reminder.message
                                self.selectedDate = reminder.date
                            }
                        }
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
            .background(Color("appBackground").opacity(0.4).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                    .foregroundStyle(Color("cancelActions"))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Speichern") {
                        if let reminder = reminder {
                            let updatedReminder = Reminder(
                                id: reminder.id,
                                message: message,
                                date: selectedDate
                            )
                            viewModel.updateReminder(reminder: updatedReminder)
                        } else {
                            let newReminder = Reminder(
                                message: message,
                                date: selectedDate
                            )
                            viewModel.addReminder(message: newReminder.message, date: newReminder.date)
                        }
                        dismiss()
                    }
                    .disabled(message.isEmpty)
                }
            }
        }
    }
}
