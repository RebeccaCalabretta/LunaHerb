//
//  WeatherView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 10.03.25.
//

import SwiftUI

struct WeatherView: View {
    
    @Binding var selectedDate: Date
    @Bindable var weatherVM: WeatherVM

    var body: some View {
        VStack {
            HStack {
                Text("Das Wetter in")
                    .font(.headline)
                    .foregroundColor(Color("text"))
                
                TextField("Ort eingeben", text: $weatherVM.location)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .frame(width: 200)
            }
            if weatherVM.temperature != "--" {
                HStack {
                    Image(systemName: weatherVM.sfSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    
                    Text("\(weatherVM.temperature)°C")
                        .font(.title)
                        .bold()
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .padding()
        .onAppear {
            Task {
                await weatherVM.getWeather(for: selectedDate)
            }
        }
    }
}

#Preview {
    WeatherView(
        selectedDate: .constant(Date()),
        weatherVM: WeatherVM()
    )
}
