//
//  FilterSection.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 01.03.25.
//

import SwiftUI

struct FilterSection: View {
    let title: String
    let items: [String]
    @Binding var selectedFilters: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ForEach(items, id: \.self) { item in
                Button(action: {
                    if selectedFilters.contains(item) {
                        selectedFilters.remove(item)
                    } else {
                        selectedFilters.insert(item)
                    }
                }) {
                    Text(item)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(selectedFilters.contains(item) ? Color("green3").opacity(0.8) : Color.gray.opacity(0.5))
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
         
        }
        
    }
}
