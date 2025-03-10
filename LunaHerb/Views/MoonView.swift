//
//  MoonView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MoonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var moonVM = MoonVM()
    @State private var weatherVM = WeatherVM()
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            if let moonData = moonVM.moonData {
                MoonHeaderView(moonData: moonData, selectedDate: $selectedDate, viewModel: $moonVM)

                WeatherView(selectedDate: $selectedDate, weatherVM: weatherVM)

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
            
            VStack(spacing: 8) {
                Text("Datum wählen:")
                    .font(.headline)
                    .foregroundColor(Color("text"))
                    .padding(8)
                
                DatePicker("Datum", selection: $moonVM.selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .padding()
                    .frame(width: 160)
                    .gradientBackground()
                    .clipShape(Capsule())
                    .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.4), radius: 2, x: 2, y: 2)
            }
            .padding(.bottom)
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
