//
//  MoonView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MoonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var viewModel = MoonVM()
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            if let moonData = viewModel.moonData {
                MoonHeaderView(moonData: moonData, selectedDate: $selectedDate, viewModel: $viewModel)

                Divider()
                
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
                
                DatePicker("Datum", selection: $viewModel.selectedDate, displayedComponents: .date)
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
                        viewModel.changeDay(by: 1)
                    } else if value.translation.width > 50 {
                        viewModel.changeDay(by: -1)
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
