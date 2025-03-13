//
//  SettingsView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isPushEnabled") private var isPushEnabled: Bool = false
    @AppStorage("pushTime") private var pushTime: Date = NotificationManager.shared.pushTime
    @AppStorage("darkMode") private var isDarkModeEnabled: Bool = false
    @AppStorage("reminderDays1") private var reminderDays1: Int = 0
    @AppStorage("reminderDays2") private var reminderDays2: Int = 0
    @Environment(\.modelContext) var modelContext
    @Environment(NotificationManager.self) private var notificationVM
    @Environment(SettingsVM.self) private var settingsVM
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Benachrichtigungen") {
                    Toggle(isPushEnabled ? "Benachrichtigungen deaktivieren" : "Benachrichtigungen aktivieren", isOn: $isPushEnabled)
                        .onChange(of: isPushEnabled) {
                            if isPushEnabled {
                                Task {
                                    await notificationVM.requestNotificationAuthorization()
                                }
                            } else {
                                notificationVM.cancelAllNotifications()
                            }
                        }
                    DatePicker("Uhrzeit wählen", selection: $pushTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .disabled(!isPushEnabled)
                        .opacity(isPushEnabled ? 1.0 : 0.5)
                    
                    if isPushEnabled {
                        VStack {
                            Picker("Erinnerung 1", selection: $reminderDays1) {
                                Text("Keine Erinnerung").tag(0)
                                ForEach(1..<8) { day in
                                    Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day as Int)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            Picker("Erinnerung 2", selection: $reminderDays2) {
                                Text("Keine Erinnerung").tag(0)
                                ForEach(1..<8) { day in
                                    if day != reminderDays1 {
                                        Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day as Int)
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.top)
                    }
                }
                Section("Dunkelmodus") {
                    Toggle(isDarkModeEnabled ? "Dunkelmodus deaktivieren" : "Dunkelmodus aktivieren", isOn: $isDarkModeEnabled)
                        .onChange(of: isDarkModeEnabled) {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
                            }
                        }
                }
            }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .globalBackground()
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    SettingsView()
        .environment(NotificationManager())
        .environment(SettingsVM())
}
