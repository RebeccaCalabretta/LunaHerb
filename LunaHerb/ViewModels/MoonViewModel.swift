//
//  MoonViewModel.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import Foundation

@Observable
final class MoonViewModel {
    var moonData: MoonData = MoonData(
        date: Date(),
        moonSymbol: "🌘",
        moonPhase: "Abnehmender Mond",
        zodiacSign: "Stier",
        favorable: ["Kräuter sammeln", "Wurzeln ernten"],
        unfavorable: ["Blüten ernten", "Gießen"]
    )
}
