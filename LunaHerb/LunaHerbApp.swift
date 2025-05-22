//
//  LunaHerbApp.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 11.02.25.
//
import SwiftUI
import SwiftData

@main
struct LunaHerbApp: App {
    
    @State private var moonVM = MoonVM()
    @State private var herbVM: HerbVM
    @State private var reminderVM: ReminderVM
    @State private var settingsVM: SettingsVM
    @State private var notificationVM = NotificationManager()
    @State private var weatherVM = WeatherVM()
    
    private let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Reminder.self, HerbData.self)
            
            let modelContext = modelContainer.mainContext
            
            _reminderVM = State(initialValue: ReminderVM(repository: ReminderRepository(modelContext: modelContext)))
            _herbVM = State(initialValue: HerbVM(modelContext: modelContext))
            _settingsVM = State(initialValue: SettingsVM(repository: ReminderRepository(modelContext: modelContext)))
            
        } catch {
            fatalError("Fehler beim Erstellen des ModelContainers: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(moonVM)
                .environment(herbVM)
                .environment(reminderVM)
                .environment(settingsVM)
                .environment(notificationVM)
                .environment(weatherVM)
                .modelContainer(modelContainer)
        }
    }
}
