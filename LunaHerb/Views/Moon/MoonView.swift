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
    @Bindable private var weatherVM = WeatherVM()
    @State private var selectedDate = Date()
    @State private var showLocationInput = false
    private var dates: [Date] = (-50...150).compactMap {
        Calendar.current.date(byAdding: .day, value: $0, to: Date())
    }
    @State private var scrollPosition: Date? = nil
    var body: some View {
        ZStack {
            VStack {
                MoonDatePicker(selectedDate: $moonVM.selectedDate, colorScheme: colorScheme)
                    .padding(.bottom)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(dates, id: \.self) { date in
                            VStack {
                                if let moonData = moonVM.moonData {
                                    MoonWeatherView(
                                        moonData: moonData,
                                        selectedDate: $selectedDate,
                                        moonVM: moonVM,
                                        weatherVM: weatherVM,
                                        showLocationInput: $showLocationInput
                                    )
                                }
                                if let moonData = moonVM.moonData {
                                    MoonActionsView(
                                        moonData: moonData,
                                        selectedDate: $selectedDate,
                                        moonVM: $moonVM,
                                        colorScheme: colorScheme
                                    )
                                }
                            }
                            .containerRelativeFrame(.horizontal)
                            .id(date)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $scrollPosition, anchor: .center)
            }
            .globalBackground()
            MoonChevronNavigation(moonVM: $moonVM, selectedDate: $selectedDate)
        }
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 200_000_000)
                let closestDate = dates.min(by: { abs($0.timeIntervalSince(Date())) < abs($1.timeIntervalSince(Date())) })
                scrollPosition = closestDate
                selectedDate = closestDate ?? Date()
                moonVM.selectedDate = selectedDate
                await weatherVM.getWeather(for: selectedDate)
            }
        }
        .onChange(of: scrollPosition) { _, newValue in
            if let newDate = newValue, selectedDate != newDate {
                selectedDate = newDate
                moonVM.selectedDate = newDate
                Task {
                    await weatherVM.getWeather(for: newDate)
                }
            }
        }
        .onChange(of: moonVM.selectedDate) { _, newValue in
            if scrollPosition != newValue {
                scrollPosition = newValue
            }
        }
    }
}

#Preview {
    MoonView()
        .environment(MoonVM())
}
