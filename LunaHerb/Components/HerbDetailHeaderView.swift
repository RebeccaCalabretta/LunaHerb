//
//  HerbDetailHeaderView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 27.02.25.
//

import SwiftUI

struct HerbDetailHeaderView: View {
    let herb: HerbData
    
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
    }
}


