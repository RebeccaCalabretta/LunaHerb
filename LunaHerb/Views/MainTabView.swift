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
            Tab("Kräuter", systemImage: "leaf.fill") {
                HerbListView()
            }
            Tab("Favoriten", systemImage: "heart.fill") {
                FavoritesListView()
            }
            Tab("Symptome", systemImage: "stethoscope") {
                SymptomListView()
            }
        }
        .tint(Color("selectedTabItem"))
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    MainTabView()
        .environment(MoonViewModel())
        .environment(HerbViewModel())
}
