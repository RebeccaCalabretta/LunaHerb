//
//  WeatherData.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation

struct WeatherData: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: DayWeather
    let condition: WeatherCondition
}

struct DayWeather: Codable {
    let avgtemp_c: Double
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}
