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
        
        VStack {
            if let moonData = viewModel.moonData {
                VStack {
                    Text(moonData.moonSymbol)
                        .font(.system(size: 36))
                    Text(moonData.moonPhase)
                        .bold()
                    Text("in \(moonData.zodiacSign)")
                }
                .frame(width: 320, height: 100)
                .foregroundColor(Color("TextButton"))
                .background(Color("CardBackground"))
                .cornerRadius(16)
                .shadow(radius: 2, x: 2, y: 2)
                
                DatePicker("Datum", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                GeneralButton(title: "Aktualisieren") {
                    Task {
                        await viewModel.fetchMoonData(for: selectedDate)
                    }
                }
                .padding()
                
                Divider()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                
                                Text("günstig:")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color.green.opacity(0.8))
                            }
                            if let favorable = moonData.favorable, !favorable.isEmpty {
                                ForEach(favorable, id: \.self) { action in
                                    Text(action)
                                        .padding(2)
                                }
                            }
                            if let favorableWeekday = moonData.favorableWeekdayActions, !favorableWeekday.isEmpty {
                                ForEach(favorableWeekday, id: \.self) { action in
                                    Text(action)
                                        .padding(2)
                                }
                            }
                            if (moonData.favorable?.isEmpty ?? true) && (moonData.favorableWeekdayActions?.isEmpty ?? true) {
                                Text("Keine günstigen Aktionen")
                                    .foregroundColor(Color(.gray))
                            }
                        }
                        .sectionBackground(colorScheme: colorScheme)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                
                                Text("ungünstig:")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color.red.opacity(0.8))
                            }
                            if let unfavorable = moonData.unfavorable, !unfavorable.isEmpty {
                                ForEach(unfavorable, id: \.self) { action in
                                    Text(action)
                                        .padding(2)
                                }
                            }
                            if let unfavorableWeekday = moonData.unfavorableWeekdayActions, !unfavorableWeekday.isEmpty {
                                ForEach(unfavorableWeekday, id: \.self) { action in
                                    Text(action)
                                        .padding(2)
                                }
                            }
                            if (moonData.unfavorable?.isEmpty ?? true) && (moonData.unfavorableWeekdayActions?.isEmpty ?? true) {
                                Text("Keine ungünstigen Aktionen")
                                    .foregroundColor(Color(.systemGray2))
                            }
                        }
                        .sectionBackground(colorScheme: colorScheme)
                    }
                    .padding()
                }
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .padding()
        .background(Color("AppBackground"))
    }
}

#Preview {
    MoonView()
        .environment(MoonViewModel())
}
