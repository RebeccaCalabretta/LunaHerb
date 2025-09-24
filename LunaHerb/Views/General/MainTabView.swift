//
//  MainTabView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    @Environment(SettingsVM.self) private var settingsVM
    @State private var isPushEnabled: Bool = false
    @State private var pushTime: Date = Date()
    @State private var isDarkModeEnabled: Bool = false
    @State private var showReminderSheet = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "tabBarBackground")
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "unselectedTabItem")
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                  .foregroundColor: UIColor(named: "unselectedTabItem") ?? UIColor.gray
              ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
        .onAppear {
            settingsVM.applyDarkMode(settingsVM.isDarkModeEnabled)
        }
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    MainTabView()
        .environment(MoonVM())
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
