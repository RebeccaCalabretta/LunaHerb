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
            MainTabView()
        }
    }
}

#Preview {
    MainView()
        .environment(MoonViewModel())
        .environment(HerbViewModel())
}
