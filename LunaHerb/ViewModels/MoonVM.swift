//
//  MoonVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import Foundation
import Observation
import CoreLocation
import EKAstrologyCalc
import SwiftUI

@Observable
@MainActor
final class MoonVM {
    
    var moonData: MoonData?
    var selectedDate: Date = Date() {
        didSet { Task { await fetchMoonData(for: selectedDate) } }
    }

    private let locationManager = CLLocationManager()
    private var moonPhaseManager: EKAstrologyCalc?
    
    init() {
        Task { await fetchMoonData() }
    }
    
    func fetchMoonData(for date: Date = Date()) async {
        let location = CLLocation(latitude: 48.12190, longitude: 7.847354)
        
        moonPhaseManager = EKAstrologyCalc(location: location)
        let info = moonPhaseManager?.getInfo(date: date)
        
        guard let moonInfo = info?.moonModels.first else { return }
        
        let translatedPhase = info!.phase.toGerman
        let translatedSign = moonInfo.sign.toGerman
        let moonSymbol = info!.phase.emoji
        
        let favorableActions = MoonConditions.getActions(
            for: info!.phase.toMoonPhase,
            zodiacSign: moonInfo.sign.toZodiacSign,
            favorable: true
        )
        let unfavorableActions = MoonConditions.getActions(
            for: info!.phase.toMoonPhase,
            zodiacSign: moonInfo.sign.toZodiacSign,
            favorable: false
        )
        let weekdayActions = GardeningAction.getWeekdayActions(for: date)
        
        self.moonData = MoonData(
            date: date,
            moonSymbol: moonSymbol,
            moonPhase: translatedPhase,
            zodiacSign: translatedSign,
            favorable: favorableActions.map { $0.text },
            unfavorable: unfavorableActions.map { $0.text },
            favorableWeekdayActions: weekdayActions.favorable.map { $0.text },
            unfavorableWeekdayActions: weekdayActions.unfavorable.map { $0.text }
        )
    }
    
    func changeDay(by days: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) {
            selectedDate = newDate
        }
    }
}
