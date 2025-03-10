//
//  WeatherVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 10.03.25.
//

import Foundation

@Observable
@MainActor
final class WeatherVM {
    
    var temperature: String = "--"
    var conditionDescription: String = "--"
    var sfSymbol: String = ""
    var location: String = "Berlin"
    
    private let weatherRepository = WeatherRepository()
    
    func getWeather(for date: Date) async {
        do {
            if let (temp, conditionDescription, sfSymbol) = try await weatherRepository.fetchWeather(for: date, location: location) {
                temperature = "\(Int(temp))°C"
                self.conditionDescription = conditionDescription
                self.sfSymbol = sfSymbol
                print("Fetched Weather: \(temperature), \(conditionDescription), \(sfSymbol)")
            } else {
                temperature = "--"
                conditionDescription = "--"
                sfSymbol = "questionmark.circle"
            }
        } catch {
            print("Fehler beim Abrufen der Wetterdaten: \(error.localizedDescription)")
        }
    }
}
