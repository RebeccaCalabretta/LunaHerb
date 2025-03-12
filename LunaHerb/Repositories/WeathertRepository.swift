//
//  WeathertRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation

class WeatherRepository {
    func fetchWeather(for date: Date, location: String) async throws -> (Double, String)? {
        let apiKey = "a23842a225e5430f9de135802252101"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(location)&dt=\(formattedDate)"
        
        print("Requesting Weather for \(location) on \(formattedDate)")
        print("Request URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    return nil
                }
            }
            
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            print("Decoded Data: \(decodedData)")

            if let forecastDay = decodedData.forecast.forecastday.first(where: { $0.date == formattedDate }) {
                let temp = forecastDay.day.maxtemp_c ?? 0.0
                let conditionDescription = forecastDay.day.condition.text
                
                guard let condition = WeatherIcon(rawValue: conditionDescription) else {
                    return (temp, "questionmark.circle")
                }
 //               let weatherIcon = WeatherIcon(rawValue: conditionDescription)?.sfSymbol ?? "questionmark.circle"
 //               print("SF Symbol: \(weatherIcon)")
                
                return (temp, condition.sfSymbol)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
