//
//  FilterSheet.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 01.03.25.
//

import SwiftUI

struct FilterSheet: View {
    
    @Environment(HerbViewModel.self) private var viewModel
    @Binding var isPresented: Bool
    @State private var selectedFilters: Set<String> = []
    var applyFilters: (Set<String>) -> ()
    
    
    var properties: [String] {
        Set(viewModel.herbs.flatMap { $0.properties }).sorted()
    }
    
    var symptoms: [String] {
        Set(viewModel.herbs.flatMap { $0.symptoms }).sorted()
    }
    
    var ingredients: [String] {
        Set(viewModel.herbs.flatMap { $0.ingredients }).sorted()
    }
    
    var body: some View {
        VStack {
            Text("Filter auswählen")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                   FilterSection(title: "Eigenschaften", items: properties, selectedFilters: $selectedFilters)
                    FilterSection(title: "Symptome", items: symptoms, selectedFilters: $selectedFilters)
                    FilterSection(title: "Inhaltsstoffe", items: ingredients, selectedFilters: $selectedFilters)
                }
            }
            GeneralButton(title: "Filter anwenden", action: {
                applyFilters(selectedFilters)
                isPresented = false
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("appBackground").opacity(0.4).ignoresSafeArea())
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}
