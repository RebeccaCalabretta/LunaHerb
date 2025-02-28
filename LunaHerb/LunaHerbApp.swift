//
//  LunaHerbApp.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 11.02.25.
//

import SwiftUI

@main
struct LunaHerbApp: App {
    @State private var moonViewModel = MoonViewModel()
    @State private var herbViewModel = HerbViewModel()
  
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(moonViewModel)
                .environment(herbViewModel)
        }
    }
}
