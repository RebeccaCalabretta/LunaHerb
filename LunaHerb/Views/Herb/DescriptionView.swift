//
//  DescriptionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct DescriptionView: View {
    var viewModel: DescriptionViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HerbSectionView(title: "Beschreibung", content: viewModel.description)
                HerbSectionView(title: "Inhaltsstoffe", content: viewModel.ingredients.joined(separator: ", "))
                HerbSectionView(title: "Ernte", content: viewModel.harvest)
            }
            .padding()
        }
    }
}
