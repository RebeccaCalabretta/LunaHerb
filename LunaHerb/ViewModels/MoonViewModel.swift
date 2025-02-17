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
        
        let translatedPhase = info?.phase.translated ?? "Unbekannt"
        let translatedSign = moonInfo.sign.translated
        let moonSymbol = info?.phase.emoji ?? ""
        
        self.moonData = MoonData(
            date: date,
            moonSymbol: moonSymbol,
            moonPhase: translatedPhase,
            zodiacSign: translatedSign,
            favorable: ["Blüten sammeln", "Gießen"],
            unfavorable: []
        )
    }
}
