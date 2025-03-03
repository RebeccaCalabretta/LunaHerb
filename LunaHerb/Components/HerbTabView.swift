//
//  HerbTabView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct HerbTabView: View {
    let herb: HerbData
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            HerbTabButton(title: "Allgemeine Info", icon: "info.circle", tag: 0, selectedTab: $selectedTab)
            HerbTabButton(title: "Wirkung", icon: "leaf", tag: 1, selectedTab: $selectedTab)
            HerbTabButton(title: "Anwendung", icon: "cross.case", tag: 2, selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color("tabBarBackground"))
        
        TabView(selection: $selectedTab) {
            DescriptionView(herb: herb).tag(0)
            EffectsView(herb: herb).tag(1)
            UsageView(herb: herb).tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: selectedTab)
    }
}
