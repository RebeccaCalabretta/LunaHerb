//
//  GradientBackgroundModifier.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 22.02.25.
//

import SwiftUI

struct GradientBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colorScheme == .dark ?
                                       [Color("green3"), Color("darkBlue")] :
                                       [Color("lightYellow"), Color("green3")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

extension View {
    func gradientBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}

#Preview {
    Text("Gradient Preview")
        .padding()
        .gradientBackground()
}
