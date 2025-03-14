//
//  DescriptionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct DetailView: View {
    var herb: HerbData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HerbSectionView(title: "Beschreibung", content: herb.detail)
                HerbSectionView(title: "Inhaltsstoffe", content: herb.ingredients)
                HerbSectionView(title: "Ernte", content: herb.harvest)
                HerbSectionView(title: "Erntezeit", content: herb.harvestTime)
            }
            .padding()
        }
    }
}
