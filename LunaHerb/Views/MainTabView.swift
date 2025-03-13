//
//  MainTabView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var isPushEnabled: Bool = false
    @State private var pushTime: Date = Date()
    @State private var isDarkModeEnabled: Bool = false
    @State private var settingsVM = SettingsVM()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectedTabItem")
        UITabBar.appearance().backgroundColor = UIColor(named: "tabBarBackground")
    }
    var body: some View {
        TabView {
            Tab("Mond", systemImage: "moon.fill") {
                MoonView()
            }
            Tab("Kräuter", systemImage: "leaf.fill") {
                HerbListView()
            }
            Tab("Favoriten", systemImage: "star.fill") {
                FavoritesListView()
            }
            Tab("Einstellungen", systemImage: "gearshape") {
                SettingsView()
            }
        }
        .tint(Color("selectedTabItem"))
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .onAppear {
            settingsVM.applyDarkMode(settingsVM.isDarkModeEnabled)
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    MainTabView()
        .environment(MoonVM())
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
