//
//  EffectsView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct EffectsView: View {
    var viewModel: EffectsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HerbSectionView(title: "Wirkung", content: viewModel.effect)
                HerbSectionView(title: "Eigenschaften", content: viewModel.properties)
            }
            .padding()
        }
    }
}

