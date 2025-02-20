//
//  MoonView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI

struct MoonView: View {
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
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("günstig:")
                        .bold()
                    if let favorable = moonData.favorable, !favorable.isEmpty {
                        Text(favorable.joined(separator: ", "))
                    } else {
                        Text("Keine günstigen Aktionen")
                            .foregroundColor(Color(.systemGray2))
                    }
                    
                    Divider()
                    
                    Text("ungünstig:")
                        .bold()
                    if let unfavorable = moonData.unfavorable, !unfavorable.isEmpty {
                        Text(unfavorable.joined(separator: ", "))
                    } else {
                        Text("Keine ungünstigen Aktionen")
                            .foregroundColor(Color(.systemGray2))
                    }
                }
                .padding()
                .foregroundColor(Color("Text"))
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
