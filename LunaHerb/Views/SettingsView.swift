//
//  SettingsView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPushEnabled: Bool
    @Binding var pushTime: Date
    @AppStorage("darkMode") private var isDarkModeEnabled: Bool = false
    @State private var reminderDays1: Int? = nil
    @State private var reminderDays2: Int? = nil
    @Environment(\.modelContext) var modelContext
    @Environment(NotificationVM.self) private var notificationVM
    
    var body: some View {
        Form {
            Section("Benachrichtigungen") {
                Toggle("Erinnerung aktivieren", isOn: $isPushEnabled)
                
                DatePicker("Uhrzeit wählen", selection: $pushTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .disabled(!isPushEnabled)
                    .opacity(isPushEnabled ? 1.0 : 0.5)
                
                if isPushEnabled {
                    VStack {
                        Text("Zusätzliche Erinnerungen")
                            .font(.headline)
                        
                        Picker("Erinnerung 1", selection: $reminderDays1) {
                            ForEach(1..<8) { day in
                                Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day as Int?)
                            }
                            Text("Keine Erinnerung").tag(nil as Int?)
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Picker("Erinnerung 2", selection: $reminderDays2) {
                            Text("Keine Erinnerung").tag(nil as Int?)
                            ForEach(1..<8) { day in
                                if day != reminderDays1 {
                                    Text("\(day) Tag\(day == 1 ? "" : "e") vorher").tag(day as Int?)
                                }
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.top)
                }
            }
            Section("Dunkelmodus") {
                Toggle("Dunkelmodus", isOn: $isDarkModeEnabled)
                    .onChange(of: isDarkModeEnabled) { newValue in
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    }
            }
        }
        .navigationTitle("Einstellungen")
        .globalBackground()
    }
}

#Preview {
    SettingsView(
        isPushEnabled: .constant(true),
        pushTime: .constant(Date())
    )
}
