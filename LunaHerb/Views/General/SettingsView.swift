//
//  SettingsView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("isPushEnabled") private var isPushEnabled: Bool = false
    @AppStorage("pushTime") private var pushTime: Date = NotificationManager.shared.pushTime
    @AppStorage("darkMode") private var isDarkModeEnabled: Bool = false
    @AppStorage("reminderDays1") private var reminderDays1: Int = 0
    @AppStorage("reminderDays2") private var reminderDays2: Int = 0
    @AppStorage("showSettingsAlert") private var showSettingsAlert: Bool = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(NotificationManager.self) private var notificationManager
    @Environment(SettingsVM.self) private var settingsVM
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Benachrichtigungen") {
                    
                    Toggle(isPushEnabled ? "Benachrichtigungen deaktivieren" : "Benachrichtigungen aktivieren", isOn: $isPushEnabled)
                        .onChange(of: isPushEnabled) {
                            if isPushEnabled {
                                Task {
                                    _ = await notificationManager.requestNotificationAuthorization()
                                    await notificationManager.checkAuthStatus()
                                }
                            } else {
                                notificationManager.cancelAllNotifications()
                            }
                        }
                    
                    DatePicker("Uhrzeit wählen", selection: $pushTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .disabled(!isPushEnabled)
                        .opacity(isPushEnabled ? 1.0 : 0.5)
                        .onChange(of: pushTime) {
                            Task {
                                await settingsVM.rescheduleAllReminders()
                            }
                        }
                    
                    if isPushEnabled {
                        VStack {
                            Picker("Erinnerung 1", selection: $reminderDays1) {
                                Text("Am Ereignistag").tag(0)
                                ForEach(1..<8) { day in
                                    Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: reminderDays1) {
                                Task {
                                    await settingsVM.rescheduleAllReminders()
                                }
                            }
                            
                            Picker("Erinnerung 2", selection: $reminderDays2) {
                                Text("Keine Erinnerung").tag(0)
                                Text("Am Ereignistag").tag(0)
                                ForEach(1..<8) { day in
                                    if day != reminderDays1 {
                                        Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day)
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: reminderDays2) {
                                Task {
                                    await settingsVM.rescheduleAllReminders()
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                
                Section("Dunkelmodus") {
                    Toggle(isDarkModeEnabled ? "Dunkelmodus deaktivieren" : "Dunkelmodus aktivieren", isOn: $isDarkModeEnabled)
                        .onChange(of: isDarkModeEnabled) {
                            settingsVM.isDarkModeEnabled = isDarkModeEnabled
                        }
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("EINSTELLUNGEN")
                        .font(.custom("AvenirNext-Regular", size: 24))
                        .foregroundColor(Color("titleText"))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .globalBackground()
            .scrollContentBackground(.hidden)
            .alert("Benachrichtigungen deaktiviert", isPresented: $showSettingsAlert) {
                Button("Einstellungen öffnen") {
                    notificationManager.openAppSettings()
                }
                Button("OK", role: .cancel) { }
            } message: {
                Text("Bitte aktiviere Mitteilungen in den iOS-Einstellungen, um Benachrichtigungen für Erinnerungen zu erhalten.")
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Reminder.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = ModelContext(container)
    
    SettingsView()
        .environment(NotificationManager())
        .environment(SettingsVM(repository: ReminderRepository(modelContext: context)))
        .modelContainer(container)
}
