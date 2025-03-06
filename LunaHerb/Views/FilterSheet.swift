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
    @Binding var selectedFilters: Set<String>
    @State private var tempSelectedFilters: Set<String> = []

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
                    FilterSection(title: "Eigenschaften", items: properties, selectedFilters: $tempSelectedFilters)
                    FilterSection(title: "Anwendungsgebiete", items: symptoms, selectedFilters: $tempSelectedFilters)
                    FilterSection(title: "Inhaltsstoffe", items: ingredients, selectedFilters: $tempSelectedFilters)
                }
            }
            
            VStack {
                GeneralButton(title: "Filter anwenden") {
                    selectedFilters = tempSelectedFilters
                    viewModel.filterHerbs(with: "", filters: selectedFilters)
                    isPresented = false
                }
                .padding(.bottom, 8)
                Button("Filter löschen") {
                    tempSelectedFilters.removeAll()
                }
                .foregroundColor(Color("cancelActions"))
            }
            .padding()
        }
        .onAppear {
            tempSelectedFilters = selectedFilters
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("appBackground").opacity(0.4).ignoresSafeArea())
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
