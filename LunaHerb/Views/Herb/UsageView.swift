//
//  UsageView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct UsageView: View {
    var herb: HerbData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HerbSectionView(title: "Anwendungsbereiche", content: herb.symptoms)
                HerbSectionView(title: "Anwendung", content: herb.usage)
            }
            .padding()
        }
    }
}
