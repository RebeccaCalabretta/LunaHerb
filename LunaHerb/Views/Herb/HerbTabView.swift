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
            HerbTabButton(title: "Beschreibung", icon: "info.circle", tag: 0, selectedTab: $selectedTab)
            HerbTabButton(title: "Wirkung", icon: "leaf", tag: 1, selectedTab: $selectedTab)
            HerbTabButton(title: "Anwendung", icon: "cross.case", tag: 2, selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color("green3").opacity(0.4))
            TabView(selection: $selectedTab) {
                DescriptionView(viewModel: herb.toDescriptionViewModel()).tag(0)
                EffectsView(viewModel: herb.toEffectsViewModel()).tag(1)
                UsageView(viewModel: herb.toUsageViewModel()).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedTab)    }
}

