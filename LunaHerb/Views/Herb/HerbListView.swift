//
//  HerbListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI

struct HerbListView: View {
    
    @Environment(HerbViewModel.self) private var viewModel
    @State private var searchText = ""
    @State private var selectedHerb: HerbData? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var searchedHerbs: [HerbData] {
        if searchText.isEmpty {
            return viewModel.herbs
        } else {
            return viewModel.herbs.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Suche nach Kräutern...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.herbs) { herb in
                            HerbCard(herb: herb)
                                .onTapGesture {
                                    selectedHerb = herb
                                }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchHerbs()
                }
            }
            .navigationTitle("Kräuterlexikon")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                // NotificationsView()
                            }) {
                                Image(systemName: "bell")
                            }
                            
                            Button(action: {
                                // SettingsView()
                            }) {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("appBackground"))
            .navigationDestination(item: $selectedHerb) { herb in
                HerbDetailView(herb: herb)
            }
        }
    }
}

#Preview {
    HerbListView()
        .environment(HerbViewModel())
}
