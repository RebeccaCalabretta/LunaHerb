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
        ZStack(alignment: .topLeading) {
            AsyncImage(url: herb.asyncImageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: 250
                        )
                        .clipped()
                    
                case .empty:
                    ZStack {
                        Color("green3")
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: 250
                            )
                        ProgressView()
                    }

                case .failure:
                    Color("green3")
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: 250
                        )

                @unknown default:
                    Color("green3")
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: 250
                        )
                }
            }

            Button(action: { dismiss() }) {
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            .padding(.top, 60)
            .padding(.leading, 16)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.toggleFavorite(for: herb)
                        }
                        herb.isFavorite.toggle()
                    }) {
                        Image(systemName: "star.fill")
                            .foregroundColor(herb.isFavorite ? Color("lightYellow") : .white)
                            .font(.system(size: 30))
                            .symbolEffect(.bounce, value: herb.isFavorite)
                            .scaleEffect(herb.isFavorite ? 1.2 : 1)
                            .animation(.easeInOut(duration: 0.2), value: herb.isFavorite)
                    }
                    .padding(20)
                }
            }
        }
        .frame(height: 250)
    }
}
