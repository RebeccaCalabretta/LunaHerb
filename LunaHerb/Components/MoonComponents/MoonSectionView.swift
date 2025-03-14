//
//  MoonSectionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 22.02.25.
//

import SwiftUI

struct MoonSectionView: View {
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
                    .foregroundColor(color)
            }
            if !actions.isEmpty || !weekdayActions.isEmpty {
                ForEach(actions + weekdayActions, id: \.self) { action in
                    Text("• ").bold() + Text("\(action)")
                }
            } else {
                Text("Keine \(title)en Aktionen")
                    .foregroundColor(Color("cardText"))
            }
        }
        .sectionBackground(colorScheme: colorScheme)
    }
}
