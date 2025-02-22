//
//  GeneralButton.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct GeneralButton: View {
    var title: String
    var action: () -> ()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor( Color("textButton"))
                .padding()
                .frame(maxWidth: 250)
                .gradientBackground()
                .cornerRadius(16)
                .padding(.horizontal)
        }
        .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.4), radius: 2, x: 2, y: 2)
    }
}

#Preview {
    GeneralButton(title: "Button", action: {
        print("Button gedrückt")
    })
}
