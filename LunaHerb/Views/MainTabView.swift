//
//  MainTabView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectedTabItem")
        UITabBar.appearance().backgroundColor = UIColor(named: "tabBarBackground")
    }
    var body: some View {
        TabView {
            Tab("Mond", systemImage: "moon.fill") {
                MoonView()
            }
            Tab("Favoriten", systemImage: "heart.fill") {
                FavoritesView()
            }
            Tab("Kräuter", systemImage: "leaf.fill") {
                HerbListView()
            }
            Tab("Symptome", systemImage: "stethoscope") {
                SymptomListView()
            }
        }
        .tint(Color("selectedTabItem"))
    }
}

#Preview {
    MainTabView()
        .environment(MoonViewModel())
        .environment(HerbViewModel())
}
