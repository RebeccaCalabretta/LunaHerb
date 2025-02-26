//
//  UsageView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct UsageView: View {
    var viewModel: UsageViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HerbSectionView(title: "Anwendungsbereiche", content: viewModel.symptoms)
                HerbSectionView(title: "Anwendung", content: viewModel.usage)
            }
            .padding()
        }
    }
}
