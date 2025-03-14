//
//  MoonCard.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 22.02.25.
//

import SwiftUI

struct MoonCard: View {
    let moonData: MoonData
    var body: some View {
        
        VStack {
            Text(moonData.moonSymbol)
                .font(.system(size: 36))
            Text(moonData.moonPhase)
                .bold()
            Text("in \(moonData.zodiacSign)")
        }
        .frame(width: 380, height: 120)
        .foregroundColor(Color("cardText"))
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(radius: 2, x: 2, y: 2)
        
        
    }
}
