//
//  MoonView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MoonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(MoonViewModel.self) private var viewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let moonData = viewModel.moonData {
                    
                    MoonCard()
                    
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
                        .padding()
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
                    
                    DatePicker("Datum", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    
                        .padding()
                        .gradientBackground()
                        .clipShape(Capsule())
                        .onChange(of: selectedDate) { newDate in
                            Task {
                                await viewModel.fetchMoonData(for: newDate)
                            }
                        }
                        .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.4), radius: 2, x: 2, y: 2)
                }
                .padding(.bottom)
            }
            .padding()
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                        } else if value.translation.width > 50 {
                            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                        }
                        Task {
                            await viewModel.fetchMoonData(for: selectedDate)
                        }
                    }
            )
            .globalBackground()
        }
    }
}

#Preview {
    MoonView()
        .environment(MoonViewModel())
}
