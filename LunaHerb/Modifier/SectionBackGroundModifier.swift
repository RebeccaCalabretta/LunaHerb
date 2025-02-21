//
//  SectionBackGroundModifier.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 21.02.25.
//

import SwiftUI

struct SectionBackgroundModifier: ViewModifier {
    var colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundColor(Color("TextButton"))
            .background(Color("CardBackground"))
            .cornerRadius(16)
            .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.4), radius: 5, x: 2, y: 2)
    }
}

extension View {
    func sectionBackground(colorScheme: ColorScheme) -> some View {
        self.modifier(SectionBackgroundModifier(colorScheme: colorScheme))
    }
}
