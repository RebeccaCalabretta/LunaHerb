//
//  MainView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        NavigationStack {
            TabView {
                Tab("Mond", systemImage: "moon.fill") {
                    MoonView()
                }
                Tab("Favoriten", systemImage: "heart.fill") {
                    // FavoritesView()
                }
                Tab("Kräuter", systemImage: "leaf.fill") {
                    // HerbListView()
                }
                Tab("Symptome", systemImage: "stethoscope") {
                    // SymptomListView()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environment(MoonViewModel())
}
