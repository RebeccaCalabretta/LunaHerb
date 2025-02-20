//
//  EKMoonEnumExtensions.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 17.02.25.
//

import EKAstrologyCalc

extension EKMoonZodiacSign {
    
    var toGerman: String {
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
    
    var toZodiacSign: ZodiacSign {
        switch self {
        case .aries: return .aries
        case .leo: return .leo
        case .sagittarius: return .sagittarius
        case .taurus: return .taurus
        case .virgo: return .virgo
        case .capricorn: return .capricorn
        case .gemini: return .gemini
        case .libra: return .libra
        case .aquarius: return .aquarius
        case .cancer: return .cancer
        case .scorpio: return .scorpio
        case .pisces: return .pisces
        }
    }
}

extension EKMoonPhase {
    
    var toGerman: String {
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
    
    var toMoonPhase: MoonPhase {
        switch self {
        case .waxingCrescent: return .waxingCrescent
        case .firstQuarter: return .firstQuarter
        case .waxingGibbous: return .waxingGibbous
        case .fullMoon: return .fullMoon
        case .waningGibbous: return .waningGibbous
        case .lastQuarter: return .lastQuarter
        case .waningCrescent: return .waningCrescent
        case .newMoon: return .newMoon
        }
    }
}
