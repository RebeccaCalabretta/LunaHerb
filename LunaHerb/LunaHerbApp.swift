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
    @State private var moonViewModel = MoonVM()
    @State private var herbViewModel: HerbVM
    @State private var reminderVM: ReminderVM
    private let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Reminder.self, HerbData.self)
            _reminderVM = State(initialValue: ReminderVM(repository: ReminderRepository(modelContext: modelContainer.mainContext)))
            _herbViewModel = State(initialValue: HerbVM(modelContext: modelContainer.mainContext))
            
        } catch {
            fatalError("Fehler beim Erstellen des ModelContainers: \(error.localizedDescription)")
        }
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(moonViewModel)
                .environment(herbViewModel)
                .environment(reminderVM)
                .modelContainer(for: [Reminder.self, HerbData.self])
        }
    }
}
