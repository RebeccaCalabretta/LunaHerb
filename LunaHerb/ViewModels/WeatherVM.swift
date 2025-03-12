//
//  WeatherVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 10.03.25.
//

import Foundation
import CoreLocation

@Observable
@MainActor
final class WeatherVM {
    
    var temperature: String = "--"
    var condition: String = "--"
    var sfSymbol: String = ""
    var selectedDate: Date = Date()
    var location: String = "Berlin"
    
    private let weatherRepository = WeatherRepository()
    
    func getCLLocation(from cityName: String) async -> CLLocation? {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(cityName)
            return placemarks.first?.location
        } catch {
            print("Fehler bei der Geocodierung: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getWeather(for date: Date) async {
        print("WeatherVM - getWeather aufgerufen mit Datum: \(date)")
        Task {
            let locationResponse = await getCLLocation(from: location)
            guard let clLocation = locationResponse else {
                return
            }
            do {
                let geocoder = CLGeocoder()
                let placemarks = try await geocoder.reverseGeocodeLocation(clLocation)
                guard let placemark = placemarks.first else {
                    return
                }
                let city = placemark.locality ?? "Unbekannt"
                
                if let (temp, sfSymbol) = try await weatherRepository.fetchWeather(for: date, location: city) {
                    self.temperature = "\(Int(temp))°C"
                    self.sfSymbol = sfSymbol
                    print("WeatherVM - Wetterdaten aktualisiert für \(date)")
                    print("🌡️ Werte gesetzt: \(self.temperature), \(self.condition), \(self.sfSymbol)")
                } else {
                        temperature = "--"
                        sfSymbol = "questionmark.circle"
                    }
            } catch {
                print("Fehler beim Abrufen der Wetterdaten: \(error.localizedDescription)")
            }
        }
    }
}
