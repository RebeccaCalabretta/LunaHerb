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
    var errorMessage: String?
    
    private let weatherRepository = WeatherRepository()
    
    func getCLLocation(from cityName: String) async -> CLLocation? {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(cityName)
            return placemarks.first?.location
        } catch {
            errorMessage = "Fehler bei der Geocodierung."
            return nil
        }
    }
    
    func getWeather(for date: Date) async {
        do {
            let locationResponse = await getCLLocation(from: location)
            guard let clLocation = locationResponse else {
                errorMessage = "Ort nicht gefunden."
                return
            }
            let geocoder = CLGeocoder()
            let placemarks = try await geocoder.reverseGeocodeLocation(clLocation)
            guard let placemark = placemarks.first else {
                errorMessage = "Fehler beim Laden des Standorts."
                return
            }
            let city = placemark.locality ?? "Unbekannt"
            
            if let (temp, sfSymbol) = try await weatherRepository.fetchWeather(for: date, location: city) {
                self.temperature = "\(Int(temp))°C"
                self.sfSymbol = sfSymbol
            } else {
                temperature = "--"
                sfSymbol = "questionmark.circle"
            }
        } catch {
            errorMessage = "Fehler beim Abrufen der Wetterdaten."
        }
    }
}
