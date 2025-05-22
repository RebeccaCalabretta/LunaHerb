//
//  LocationWeatherView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 14.03.25.
//

import SwiftUI

struct LocationWeatherView: View {
    @AppStorage("savedLocation") private var savedLocation: String = "Berlin"
    @Bindable var weatherVM: WeatherVM
    @Binding var selectedDate: Date
    @Binding var showLocationInput: Bool

    @State private var tempLocation: String = ""
    @State private var previousLocation: String = ""

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
                previousLocation = weatherVM.location
                tempLocation = ""
                showLocationInput = true
            }

            Spacer(minLength: 50)

            WeatherView(weatherVM: weatherVM)
                .frame(minWidth: 100)
                .padding(.trailing, 8)
        }
        .onAppear {
            weatherVM.location = savedLocation
        }
        .alert("Ort ändern", isPresented: $showLocationInput) {
            TextField("Neuer Ort", text: $tempLocation)

            Button("Fertig", role: .none) {
                if !tempLocation.isEmpty {
                    weatherVM.location = tempLocation
                    savedLocation = tempLocation
                    Task {
                        await weatherVM.getWeather(for: selectedDate)
                    }
                }
            }
            
            Button("Abbrechen", role: .cancel) {
                weatherVM.location = previousLocation
            }
        }
    }
}
