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
        VStack {
            
            MoonDatePicker(selectedDate: $moonVM.selectedDate, colorScheme: colorScheme)
                .padding(.bottom)
            HStack {
                Spacer(minLength: 40)
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
                
                Spacer(minLength: 20)

                WeatherView(weatherVM: weatherVM)
                    .frame(minWidth: 100)
                    .padding(.trailing, 20)
                Spacer(minLength: 40)
            }
            .alert("Ort ändern", isPresented: $showLocationInput) {
                TextField("Neuer Ort", text: $weatherVM.location)
                Button("Fertig", role: .none) {
                    Task {
                        await weatherVM.getWeather(for: selectedDate)                                    }
                }
                Button("Abbrechen", role: .cancel) { }
            }
            if let moonData = moonVM.moonData {
                MoonHeaderView(moonData: moonData, selectedDate: $selectedDate, viewModel: $moonVM)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        MoonSectionView(
                            title: "günstig",
                            icon: "checkmark.circle.fill",
                            color: .favorableTitle,
                            actions: moonData.favorable ?? [],
                            weekdayActions: moonData.favorableWeekdayActions ?? [],
                            colorScheme: colorScheme
                        )
                        MoonSectionView(
                            title: "ungünstig",
                            icon: "xmark.circle.fill",
                            color: .unfavorableTitle,
                            actions: moonData.unfavorable ?? [],
                            weekdayActions: moonData.unfavorableWeekdayActions ?? [],
                            colorScheme: colorScheme
                        )
                    }
                    .padding(20)
                }
            } else {
                ProgressView()
            }
            Spacer()
        }
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
        .padding()
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
    }
}

#Preview {
    MoonView()
        .environment(MoonVM())
}
