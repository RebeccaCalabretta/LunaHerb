//
//  HerbCardView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbCard: View {
    
    let herb: HerbData
    @Environment(HerbViewModel.self) private var viewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: herb.asyncImageURL) { image in
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
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0.0, bottomLeading: 12.0, bottomTrailing: 12.0, topTrailing: 0.0), style: .continuous)
                        .foregroundColor(.black.opacity(0.6))
                )
        }
        .frame(width: 170, height: 170)
        .overlay(
            Button(action: {
                Task {
                    await viewModel.toggleFavorite(for: herb)
                }
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(herb.isFavorite ? .red : .white)
                    .font(.system(size: 20))
            }
            .padding(10), alignment: .topTrailing

        )
    }
}
   
    
