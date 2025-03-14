//
//  MoonView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI
import CoreLocation

struct MoonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var moonVM = MoonVM()
    @State private var weatherVM = WeatherVM()
    @State private var selectedDate = Date()
    @State private var showLocationInput = false
    
    var body: some View {
        ZStack {
            VStack {
                MoonDatePicker(selectedDate: $moonVM.selectedDate, colorScheme: colorScheme)
                    .padding(.bottom)
                
                LocationWeatherView(weatherVM: weatherVM, selectedDate: $selectedDate, showLocationInput: $showLocationInput)
                
                if let moonData = moonVM.moonData {
                    MoonInfoView(moonData: moonData, selectedDate: $selectedDate, moonVM: $moonVM, colorScheme: colorScheme)
                } else {
                    ProgressView()
                }
                Spacer()
            }
            .padding()
            .onAppear {
                Task {
                    await weatherVM.getWeather(for: selectedDate)
                }
            }
            .onChange(of: moonVM.selectedDate) { oldValue, newValue in
                Task {
                    await weatherVM.getWeather(for: newValue)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 {
                            moonVM.changeDay(by: 1)
                        } else if value.translation.width > 50 {
                            moonVM.changeDay(by: -1)
                        }
                    }
            )
            .globalBackground()

            MoonChevronNavigation(moonVM: $moonVM, selectedDate: $selectedDate)
        }
    }
}

#Preview {
    MoonView()
        .environment(MoonVM())
}
