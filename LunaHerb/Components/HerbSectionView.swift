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
                .foregroundStyle(Color("titleText"))
            
            if let contentArray = content as? [String] {
                ForEach(contentArray, id: \.self) { item in
                    Text("• ").bold() + Text(item)
                        .font(.body)
                    .foregroundStyle(Color("cardText"))                }
            } else if let contentText = content as? String {
                let parts = contentText.split(separator: "\n").map { String($0) }
                
                ForEach(parts, id: \.self) { part in
                    if let attributedString = try? AttributedString(markdown: part) {
                        Text(attributedString)
                            .font(.body)
                            .foregroundStyle(Color("cardText")).padding(.vertical, 2)
                    } else {
                        Text(part)
                            .font(.body)
                            .foregroundStyle(Color("cardText")).padding(.vertical, 2)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HerbSectionView(title: "Test Titel", content: "Dies ist ein Beispieltext")
}

