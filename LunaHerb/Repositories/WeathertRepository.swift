//
//  WeathertRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation

class WeatherRepository {
    func getWeather(for date: Date, location: String) async throws -> (Double, String)? {
        let urlString = "https://api.weatherapi.com/v1/history.json?key=a23842a225e5430f9de135802252101&q=\(location)&dt=\(date.formatted(.dateTime.year().month().day()))"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        let temp = decodedData.current.temp_c
        let conditionDescription = decodedData.current.condition.rawValue
        
        return (temp, conditionDescription)
    }
}
