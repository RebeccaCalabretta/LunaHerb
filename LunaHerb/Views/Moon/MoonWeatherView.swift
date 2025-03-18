//
//  MoonWeatherView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 28.02.25.
//

import SwiftUI

struct MoonWeatherView: View {
    
    let moonData: MoonData
    @Binding var selectedDate: Date
    @Bindable var moonVM: MoonVM
    @Bindable var weatherVM: WeatherVM

    @Binding var showLocationInput: Bool

    var body: some View {
        VStack {
            MoonCard(moonData: moonData)
            LocationWeatherView(weatherVM: weatherVM, selectedDate: $selectedDate, showLocationInput: $showLocationInput)
        }
        .frame(height: 160)
        .foregroundColor(Color("cardText"))
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(radius: 2, x: 2, y: 2)
        .padding(.bottom, 8)
        .padding(.horizontal)
    }
}


