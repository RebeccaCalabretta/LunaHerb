//
//  WeatherIcon.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation

enum WeatherIcon: String, Codable {
    case sunny = "Sunny"
    case clear = "Clear"
    case partlyCloudy = "Partly Cloudy "
    case cloudy = "Cloudy"
    case overcast = "Overcast "
    case mist = "Mist"
    case patchyRainPossible = "Patchy rain possible"
    case patchyRainNearby = "Patchy rain nearby"
    case patchySnowPossible = "Patchy snow possible"
    case patchySleetPossible = "Patchy sleet possible"
    case patchyFreezingDrizzlePossible = "Patchy freezing drizzle possible"
    case thunderyOutbreaksPossible = "Thundery outbreaks possible"
    case fog = "Fog"
    case freezingFog = "Freezing fog"
    case lightRain = "Light rain"
    case moderateRain = "Moderate rain"
    case heavyRain = "Heavy rain"
    case lightSnow = "Light snow"
    case heavySnow = "Heavy snow"
    case thunderstorm = "Moderate or heavy rain with thunder"

    var sfSymbol: String {
        switch self {
        case .sunny, .clear:
            return "sun.max"
        case .partlyCloudy:
            return "cloud.sun"
        case .cloudy, .overcast:
            return "cloud"
        case .mist, .fog, .freezingFog:
            return "cloud.fog"
        case .patchyRainPossible, .lightRain, .patchyRainNearby:
            return "cloud.drizzle"
        case .heavyRain:
            return "cloud.heavyrain"
        case .patchySnowPossible, .lightSnow:
            return "cloud.snow"
        case .heavySnow:
            return "snowflake"
        case .thunderyOutbreaksPossible, .thunderstorm:
            return "cloud.bolt.rain"
        default:
            return "questionmark.circle"
        }
    }
}
