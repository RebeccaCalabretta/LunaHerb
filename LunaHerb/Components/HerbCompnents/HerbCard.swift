//
//  HerbCardView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbCard: View {
    
    let herb: HerbData
    @Environment(HerbVM.self) private var viewModel
    
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
                herb.isFavorite.toggle()
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(herb.isFavorite ? Color("lightYellow") : .white)
                    .font(.system(size: 20))
                    .symbolEffect(.bounce, value: herb.isFavorite )
                    .scaleEffect(herb.isFavorite  ? 1.2 : 1)
                    .animation(.easeInOut(duration: 0.2), value: herb.isFavorite )
            }
            .padding(10), alignment: .topTrailing

        )
    }
}
