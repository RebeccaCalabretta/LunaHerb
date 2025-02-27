//
//  HerbDetailHeaderView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI

struct HerbDetailHeaderView: View {
    let herb: HerbData
    @Environment(HerbViewModel.self) private var viewModel
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: herb.asyncImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 250)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            } placeholder: {
                Color("green3")
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .frame(height: 150)
        .overlay(
            Button(action: {
                Task {
                    await viewModel.toggleFavorite(for: herb)
                }
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(herb.isFavorite ? .red : .white)
                    .font(.system(size: 30))
            }
            .padding(20), alignment: .bottomTrailing

        )
    }
}


