//
//  EnumExtensions.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 17.02.25.
//

import EKAstrologyCalc

extension EKMoonZodiacSign {
    
    var translated: String {
        switch self {
        case .aries: return "Widder"
        case .taurus: return "Stier"
        case .gemini: return "Zwillinge"
        case .cancer: return "Krebs"
        case .leo: return "Löwe"
        case .virgo: return "Jungfrau"
        case .libra: return "Waage"
        case .scorpio: return "Skorpion"
        case .sagittarius: return "Schütze"
        case .capricorn: return "Steinbock"
        case .aquarius: return "Wassermann"
        case .pisces: return "Fische"
        }
    }
}

extension EKMoonPhase {
    
    var translated: String {
        switch self {
        case .newMoon: return "Neumond"
        case .waxingCrescent: return "Zunehmende Sichel"
        case .firstQuarter: return "Zunehmender Halbmond"
        case .waxingGibbous: return "Zunehmender Mond"
        case .fullMoon: return "Vollmond"
        case .waningGibbous: return "Abnehmender Mond"
        case .lastQuarter: return "Abnehmender Halbmond"
        case .waningCrescent: return "Abnehmende Sichel"
        }
    }
}

extension EKMoonPhase {
    
    var emoji: String {
        switch self {
        case .newMoon: return "🌑"
        case .waxingCrescent: return "🌒"
        case .firstQuarter: return "🌓"
        case .waxingGibbous: return "🌔"
        case .fullMoon: return "🌕"
        case .waningGibbous: return "🌖"
        case .lastQuarter: return "🌗"
        case .waningCrescent: return "🌘"
        }
    }
}
