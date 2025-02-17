//
//  MoonViewModel.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

//import Foundation
//
//@Observable
//final class MoonViewModel {
//    var moonData: MoonData = MoonData(
//        date: Date(),
//        moonSymbol: "🌘",
//        moonPhase: "Abnehmender Mond",
//        zodiacSign: "Stier",
//        favorable: ["Kräuter sammeln", "Wurzeln ernten"],
//        unfavorable: ["Blüten ernten", "Gießen"]
//    )
//}

import Foundation
import CoreLocation
import EKAstrologyCalc

@Observable
@MainActor
final class MoonViewModel {
    var moonData: MoonData?
    private let locationManager = CLLocationManager()
    private var moonPhaseManager: EKAstrologyCalc?
    
    init() {
        Task {
            await fetchMoonData()
        }
    }
    
    func fetchMoonData(for date: Date = Date()) async {
        let location = CLLocation(latitude: 48.12190, longitude: 7.847354)
        
        moonPhaseManager = EKAstrologyCalc(location: location)
        let info = moonPhaseManager?.getInfo(date: date)
        
        guard let moonInfo = info?.moonModels.first else { return }
        
        self.moonData = MoonData(
            date: date,
            moonSymbol: "🌙",
            moonPhase: info?.phase.rawValue ?? "Unbekannt",
            zodiacSign: moonInfo.sign.rawValue,
            favorable: ["Blüten sammeln", "Gießen"],
            unfavorable: []
        )
    }
}
