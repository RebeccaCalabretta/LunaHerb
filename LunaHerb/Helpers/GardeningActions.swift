//
//  GardeningActions.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import Foundation

enum GardeningAction: String {
    case fruchtpflanzenSaeen
    case wurzelgemueseSaeen
    case blattgemueseSaeen
    case blumenHeilkraeuterSaeen
    case kraeuterAetherischeOele
    case kraeuterFolienbeet
    case freilandUmpflanzen
    case wurzelnErnten
    case blaetterErnten
    case brennnesselnErnten
    case bluetenErnten
    case giessenTopfKuebel
    case petersilieSaeen
    case heilkraeuterAufbewahrung
    
    var text: String {
        switch self {
        case .fruchtpflanzenSaeen: "Fruchtpflanzen säen/setzen"
        case .wurzelgemueseSaeen: "Wurzelgemüse säen/setzen"
        case .blattgemueseSaeen: "Blattgemüse säen/setzen"
        case .blumenHeilkraeuterSaeen: "Blumen & Heilkräuter säen/setzen"
        case .kraeuterAetherischeOele: "Kräuter mit ätherischen Ölen säen/setzen"
        case .kraeuterFolienbeet: "Kräuter im Folienbeet anbauen"
        case .freilandUmpflanzen: "Pflanzen ins Freiland umsetzen"
        case .wurzelnErnten: "Wurzeln ernten"
        case .blaetterErnten: "Blätter ernten"
        case .brennnesselnErnten: "Brennnesseln ernten"
        case .bluetenErnten: "Blüten ernten"
        case .giessenTopfKuebel: "Gießen von Topf- und Kübelkräuter"
        case .petersilieSaeen: "Mittwoch vormittags Petersilie säen, unabhängig vom Mondstand"
        case .heilkraeuterAufbewahrung: "Freitag und Sonntag generell ungünstig für die Ernte zur Aufbewahrung von Heilkräutern. Diese merkwürdige Regel beweist sich durch Ihre Erfahrung"
        }
    }
    
    static func getWeekdayActions(for date: Date) -> WeekdayActions {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 4:
            return WeekdayActions(favorable: [.petersilieSaeen], unfavorable: [])
        case 6, 1:
            return WeekdayActions(favorable: [], unfavorable: [.heilkraeuterAufbewahrung])
        default:
            return WeekdayActions(favorable: [], unfavorable: [])
        }
    }
}

struct WeekdayActions {
    let favorable: [GardeningAction]
    let unfavorable: [GardeningAction]
}
