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
}

struct DayWeather: Codable {
    let maxtemp_c: Double?
    let condition: WeatherCondition
}

struct WeatherCondition: Codable {
    let text: String
}
