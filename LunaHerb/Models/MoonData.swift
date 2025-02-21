//
//  MoonData.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import Foundation

struct MoonData {
    let date: Date
    let moonSymbol: String
    let moonPhase: String
    let zodiacSign: String
    let favorable: [String]?
    let unfavorable: [String]?
    let favorableWeekdayActions: [String]?
    let unfavorableWeekdayActions: [String]?
}
