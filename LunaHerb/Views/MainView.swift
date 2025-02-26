//
//  MainView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectedTabItem")
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
    MainView()
        .environment(MoonViewModel())
        .environment(HerbViewModel())
    
}
