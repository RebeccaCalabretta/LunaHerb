//
//  HerbCardView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbCard: View {
    
    let herb: HerbData
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: herb.asyncImageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 170, height: 170)
            .clipShape(.rect(cornerRadius: 12))
            Text(herb.name)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(6)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(.black.opacity(0.6))
                )        }
        .frame(width: 170, height: 170)
        
    }
}

