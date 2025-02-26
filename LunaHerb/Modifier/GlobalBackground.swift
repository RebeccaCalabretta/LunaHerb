//
//  GlobalBackground.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import SwiftUI

struct GlobalBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color(Color("appBackground")).ignoresSafeArea()
            content
        }
    }
}

extension View {
    func globalBackground() -> some View {
        modifier(GlobalBackground())
    }
}


