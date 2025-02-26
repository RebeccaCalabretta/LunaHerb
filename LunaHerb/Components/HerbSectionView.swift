//
//  HerbSectionView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct HerbSectionView: View {
    let title: String
    let content: Any
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            if let contentArray = content as? [String] {
                ForEach(contentArray, id: \.self) { item in
                    Text("• ").bold() + Text(item)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                
            } else if let contentText = content as? String {
                Text(contentText)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    HerbSectionView(title: "Test Titel", content: "Dies ist ein Beispieltext")
}

