//
//  SectionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 22.02.25.
//

import SwiftUI

struct SectionView: View {
    let title: String
    let icon: String
    let color: Color
    let actions: [String]
    let weekdayActions: [String]
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text("\(title):")
                    .font(.title3)
                    .bold()
                    .foregroundColor(color.opacity(0.8))
            }
            if !actions.isEmpty || !weekdayActions.isEmpty {
                ForEach(actions + weekdayActions, id: \.self) { action in
                    Text("• ").bold() + Text("\(action)")
                }
            } else {
                Text("Keine \(title)en Aktionen")
                    .foregroundColor(Color(.systemGray2))
            }
        }
        .sectionBackground(colorScheme: colorScheme)
    }
}
