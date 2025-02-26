//
//  HerbTabButton.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct HerbTabButton: View {
    let title: String
    let icon: String
    let tag: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tag
        }) {
            VStack {
                Image(systemName: icon)
                Text(title)
            }
            .foregroundStyle(selectedTab == tag ? Color("selectedTabItem") : Color("unselectedTabItem"))
            .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
    }
}

