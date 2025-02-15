//
//  TabsView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct TabsView: View {
    
    var body: some View {
        TabView {
            Tab("Mond", systemImage: "moon.fill") {
                
            }
            Tab("Favoriten", systemImage: "heart.fill") {

            }
            Tab("Kräuter", systemImage: "leaf.fill") {
               
            }
            Tab("Symptome", systemImage: "stethoscope") {
               
            }
        }
    }
}

#Preview {
    TabsView()
}
