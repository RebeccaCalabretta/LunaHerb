//
//  HerbDetailHeaderView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI

struct HerbDetailHeaderView: View {
    let herb: HerbData
    @Environment(HerbVM.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
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

                Button(action: {
                    dismiss()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 36, height: 36)
                        
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.leading, 20)
            }
        }
        .frame(height: 188)
        .overlay(

            Button(action: {
                Task {
                    await viewModel.toggleFavorite(for: herb)
                }
                herb.isFavorite.toggle()
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(herb.isFavorite ? Color("lightYellow") : .white)
                    .font(.system(size: 30))
                    .symbolEffect(.bounce, value: herb.isFavorite )
                    .scaleEffect(herb.isFavorite  ? 1.2 : 1)
                    .animation(.easeInOut(duration: 0.2), value: herb.isFavorite )
            }
            .padding(20),
            alignment: .bottomTrailing
        )
    }
}
