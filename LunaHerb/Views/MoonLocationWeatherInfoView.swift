//
//  MoonLocationWeatherInfoView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 14.03.25.
//

import SwiftUI

struct MoonLocationWeatherInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    var weatherVM: WeatherVM
    @Binding var moonVM: MoonVM
    @Binding var selectedDate: Date
    @Binding var showLocationInput: Bool
    var moonData: MoonData?

    var body: some View {
        VStack {
            LocationWeatherView(weatherVM: weatherVM, selectedDate: $selectedDate, showLocationInput: $showLocationInput)
            
            if let moonData = moonData {
                MoonInfoView(moonData: moonData, selectedDate: $selectedDate, moonVM: $moonVM, colorScheme: colorScheme)
            } else {
                ProgressView()
            }
        }
    }
}


