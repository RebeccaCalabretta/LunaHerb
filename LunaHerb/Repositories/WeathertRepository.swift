//
//  WeathertRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation

class WeatherRepository {
    func fetchWeather(for date: Date, location: String) async throws -> (Double, String, String)? {
        let apiKey = "a23842a225e5430f9de135802252101"
        let urlString = "https://api.weatherapi.com/v1/history.json?key=\(apiKey)&q=\(location)&dt=\(date.formatted(.dateTime.year().month().day()))"
        print("Request URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    throw NSError(domain: "Invalid Response", code: httpResponse.statusCode, userInfo: nil)
                }
            }
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            print("Decoded Data: \(decodedData)")
            
            if let forecastDay = decodedData.forecast.forecastday.first(where: { $0.date == date.formatted(.dateTime.year().month().day()) }) {
                let temp = forecastDay.day.avgtemp_c
                let conditionDescription = forecastDay.day.condition.text
                
                let weatherIcon = WeatherIcon(rawValue: conditionDescription.lowercased())?.sfSymbol ?? "questionmark.circle"
                
                return (temp, conditionDescription, weatherIcon) as! (Double, String, String)
            } else {
                return nil
            }
        } catch {
            print("Error while fetching weather: \(error.localizedDescription)")
            throw error
        }
    }
}
