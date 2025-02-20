//
//  GardeningActions.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import EKAstrologyCalc

enum GardeningAction: String {
    case fruchtpflanzenSaeen = "Fruchtpflanzen säen/setzen"
    case wurzelgemueseSaeen = "Wurzelgemüse säen/setzen"
    case blattgemueseSaeen = "Blattgemüse säen/setzen"
    case blumenHeilkraeuterSaeen = "Blumen & Heilkräuter säen/setzen"
    case kraeuterAetherischeOele = "Kräuter mit ätherischen Ölen säen/setzen"
    case kraeuterFolienbeet = "Kräuter im Folienbeet anbauen"
    case freilandUmpflanzen = "Pflanzen ins Freiland umsetzen"
    case wurzelnErnten = "Wurzeln ernten"
    case blaetterErnten = "Blätter ernten"
    case brennnesselnErnten = "Brennnesseln ernten"
    case bluetenErnten = "Blüten ernten"
    case giessenTopfKuebel = "Gießen von Topf- und Kübelkräuter"
}

enum MoonPhase {
    case newMoon, waxingCrescent, firstQuarter, waxingGibbous, fullMoon, waningGibbous, lastQuarter, waningCrescent
}

enum ZodiacSign {
    case aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
}

struct MoonCondition {
    let moonPhases: Set<MoonPhase>
    let zodiacSigns: Set<ZodiacSign>
}

private let favorableMoonConditions: [GardeningAction: MoonCondition] = [
    .fruchtpflanzenSaeen: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                        zodiacSigns: [.aries, .leo, .sagittarius]),
    .wurzelgemueseSaeen: MoonCondition(moonPhases: [.waningGibbous, .lastQuarter, .waningCrescent],
                                       zodiacSigns: [.virgo, .capricorn, .taurus]),
    .blattgemueseSaeen: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                      zodiacSigns: [.cancer, .scorpio, .pisces]),
    .blumenHeilkraeuterSaeen: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                            zodiacSigns: [.gemini, .libra, .aquarius]),
    .kraeuterAetherischeOele: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                            zodiacSigns: [.gemini, .libra]),
    .kraeuterFolienbeet: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                       zodiacSigns: [.cancer, .pisces]),
    .freilandUmpflanzen: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                       zodiacSigns: [.virgo]),
    .wurzelnErnten: MoonCondition(moonPhases: [.waningCrescent],
                                  zodiacSigns: [.virgo, .capricorn]),
    .blaetterErnten: MoonCondition(moonPhases: [.waxingCrescent, .firstQuarter, .waxingGibbous],
                                   zodiacSigns: [.cancer, .scorpio, .pisces]),
    .brennnesselnErnten: MoonCondition(moonPhases: [.waningGibbous, .lastQuarter, .waningCrescent],
                                       zodiacSigns: []),
    .bluetenErnten: MoonCondition(moonPhases: [.fullMoon, .waxingCrescent, .firstQuarter, .waxingGibbous],
                                  zodiacSigns: [.gemini, .libra, .aquarius]),
    .giessenTopfKuebel: MoonCondition(moonPhases: [],
                                      zodiacSigns: [.cancer, .scorpio, .pisces])
]

private let unfavorableMoonConditions: [GardeningAction: MoonCondition] = [
    .blaetterErnten: MoonCondition(moonPhases: [], zodiacSigns: [.virgo]),
    .giessenTopfKuebel: MoonCondition(moonPhases: [], zodiacSigns: [.aries, .taurus, .gemini, .leo, .virgo, .libra, .sagittarius, .capricorn, .aquarius])
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
