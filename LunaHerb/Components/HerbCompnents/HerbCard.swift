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
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack(alignment: .bottom) {
                AsyncImage(url: herb.asyncImageURL) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.gray
                            ProgressView()
                        }

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    case .failure:
                        Color.gray

                    @unknown default:
                        Color.gray
                    }
                }
                .frame(width: size.width, height: size.height)
                .clipped()
                .clipShape(.rect(cornerRadius: 12))

                Text(herb.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 0,
                                bottomLeading: 12,
                                bottomTrailing: 12,
                                topTrailing: 0
                            ),
                            style: .continuous
                        )
                        .foregroundColor(.black.opacity(0.6))
                    )
            }
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
                        .symbolEffect(.bounce, value: herb.isFavorite)
                        .scaleEffect(herb.isFavorite ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.2), value: herb.isFavorite)
                }
                .padding(10),
                alignment: .topTrailing
            )
        }
    }
}
