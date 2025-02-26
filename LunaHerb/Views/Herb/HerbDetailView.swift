//
//  HerbDetailView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbDetailView: View {
    let herb: HerbData
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                AsyncImage(url: herb.asyncImageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 250)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    Color(".gray")
                }
            }
            .frame(height: 150)
            HerbTabView(herb: herb, selectedTab: $selectedTab)
        }
        .globalBackground()
    }
}


