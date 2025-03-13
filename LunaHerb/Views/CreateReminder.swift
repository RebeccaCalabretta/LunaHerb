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
                Section("Erinnerung") {
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
                        Text("Datum wählen")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                        Spacer()
                        DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
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
                            reminder.message = message
                            reminder.date = selectedDate
                            Task {
                                await viewModel.updateReminder(reminder: reminder)
                                self.reminder = nil
                            }
                        } else {
                            let newReminder = Reminder(message: message, date: selectedDate)
                            Task {
                                await viewModel.addReminder(reminder: newReminder)
                                self.reminder = nil
                            }
                        }
                        dismiss()
                    }
                    .disabled(message.isEmpty)
                }
            }
        }
    }
}
