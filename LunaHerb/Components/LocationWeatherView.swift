//
//  LocationWeatherView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 14.03.25.
//

import SwiftUI

struct LocationWeatherView: View {
    @Bindable var weatherVM: WeatherVM
    @Binding var selectedDate: Date
    @Binding var showLocationInput: Bool

    var body: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "chevron.down")
                    .font(.system(size: 14))
                    .foregroundStyle(Color("text"))
                
                Text(weatherVM.location)
                    .font(.system(size: 18))
            }
            .padding(.leading, 20)
            .onTapGesture {
                showLocationInput = true
            }
            
            Spacer(minLength: 50)

            WeatherView(weatherVM: weatherVM)
                .frame(minWidth: 100)
                .padding(.trailing, 8)
        }
        .frame(width: 380, height: 50)
        .foregroundColor(Color("cardText"))
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(radius: 2, x: 2, y: 2)
        .alert("Ort ändern", isPresented: $showLocationInput) {
            TextField("Neuer Ort", text: $weatherVM.location)
            Button("Fertig", role: .none) {
                Task {
                    await weatherVM.getWeather(for: selectedDate)
                }
            }
            Button("Abbrechen", role: .cancel) { }
        }
    }
}


