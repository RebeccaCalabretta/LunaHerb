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
            VStack {
                Text(viewModel.moonData.moonSymbol)
                    .font(.system(size: 36))
                Text(viewModel.moonData.moonPhase)
                    .bold()
                Text("im \(viewModel.moonData.zodiacSign)")
            }
            .frame(width: 320 ,height: 100)
            .foregroundColor(.white)
            .background(Color("CardBackground")).overlay(Color(.gray).opacity(0)).cornerRadius(16)
            
            DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            GeneralButton(title: "Aktualisieren") {
                // Funktion um die MondDaten zu aktualisieren
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("günstig:")
                    .bold()
                Text(viewModel.moonData.favorable.joined(separator: ", "))
                Divider()
                Text("ungünstig:")
                    .bold()
                Text(viewModel.moonData.unfavorable.joined(separator: ", "))
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MoonView()
        .environment(MoonViewModel())
}
