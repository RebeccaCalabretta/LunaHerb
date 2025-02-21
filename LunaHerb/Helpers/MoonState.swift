//
//  MoonState.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 21.02.25.
//

import Foundation

enum MoonPhase {
    case newMoon, waxingCrescent, firstQuarter, waxingGibbous, fullMoon, waningGibbous, lastQuarter, waningCrescent
}

enum ZodiacSign {
    case aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
}

struct MoonState {
    let moonPhases: Set<MoonPhase>
    let zodiacSigns: Set<ZodiacSign>
}

private let favorableMoonConditions: [GardeningAction: MoonState] = [
    .fruchtpflanzenSaeen: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                    zodiacSigns: [.aries, .leo, .sagittarius]),
    .wurzelgemueseSaeen: MoonState(moonPhases: [.waningGibbous, .lastQuarter, .waningCrescent],
                                   zodiacSigns: [.virgo, .capricorn, .taurus]),
    .blattgemueseSaeen: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                  zodiacSigns: [.cancer, .scorpio, .pisces]),
    .blumenHeilkraeuterSaeen: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                        zodiacSigns: [.gemini, .libra, .aquarius]),
    .kraeuterAetherischeOele: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                        zodiacSigns: [.gemini, .libra]),
    .kraeuterFolienbeet: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                   zodiacSigns: [.cancer, .pisces]),
    .freilandUmpflanzen: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                   zodiacSigns: [.virgo]),
    .wurzelnErnten: MoonState(moonPhases: [.waningCrescent],
                              zodiacSigns: [.virgo, .capricorn]),
    .blaetterErnten: MoonState(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                               zodiacSigns: [.cancer, .scorpio, .pisces]),
    .brennnesselnErnten: MoonState(moonPhases: [.waningGibbous, .lastQuarter, .waningCrescent],
                                   zodiacSigns: []),
    .bluetenErnten: MoonState(moonPhases: [.fullMoon, .waxingCrescent, .firstQuarter, .waxingGibbous],
                              zodiacSigns: [.gemini, .libra, .aquarius]),
    .giessenTopfKuebel: MoonState(moonPhases: [],
                                  zodiacSigns: [.cancer, .scorpio, .pisces])
]

private let unfavorableMoonConditions: [GardeningAction: MoonState] = [
    .blaetterErnten: MoonState(moonPhases: [], zodiacSigns: [.virgo]),
    .giessenTopfKuebel: MoonState(moonPhases: [], zodiacSigns: [.aries, .taurus, .gemini, .leo, .virgo, .libra, .sagittarius, .capricorn, .aquarius])
]

struct MoonConditions {
    static func getActions(for phase: MoonPhase, zodiacSign: ZodiacSign, favorable: Bool) -> [GardeningAction] {
        let conditions = favorable ? favorableMoonConditions : unfavorableMoonConditions
        
        return conditions.filter { (_, condition) in
            let phaseMatches = condition.moonPhases.isEmpty || condition.moonPhases.contains(phase)
            let signMatches = condition.zodiacSigns.isEmpty || condition.zodiacSigns.contains(zodiacSign)
            return phaseMatches && signMatches
        }
        .map { $0.key }
    }
}
