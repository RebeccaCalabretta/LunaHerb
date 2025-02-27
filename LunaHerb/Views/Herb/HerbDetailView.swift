//
//  HerbDetailView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbDetailView: View {
    let herb: HerbData
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HerbDetailHeaderView(herb: herb)
            HerbTabView(herb: herb, selectedTab: $selectedTab)
        }
        .globalBackground()
    }
}


