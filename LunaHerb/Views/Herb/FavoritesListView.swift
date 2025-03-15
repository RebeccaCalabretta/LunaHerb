//
//  FavoritesListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI
import SwiftData

struct FavoritesListView: View {
    @Environment(HerbVM.self) private var viewModel
    @State private var searchText = ""
    @State private var selectedHerb: HerbData? = nil
    @State private var showFilterSheet = false
    @State private var selectedFilters: Set<String> = []
    
    var favoriteHerbs: [HerbData] {
        if searchText.isEmpty && selectedFilters.isEmpty {
            return viewModel.getFavoriteHerbs()
        } else {
            return viewModel.filteredFavHerbs
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        showFilterSheet = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundStyle(Color("selectedTabItem"))
                            .padding(.leading, 5)
                    }
                    
                    Spacer()
                    
                    if !selectedFilters.isEmpty {
                        Button {
                            selectedFilters.removeAll()
                            viewModel.filteredHerbs = viewModel.herbs
                        } label: {
                            Text("Filter löschen")
                                .font(.headline)
                                .foregroundColor(Color("selectedTabItem"))
                        }
                        .padding(.trailing, 5)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(favoriteHerbs) { herb in
                            HerbCard(herb: herb)
                                .onTapGesture {
                                    selectedHerb = herb
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favoriten")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedHerb) { herb in
                HerbDetailView(herb: herb)
            }
            .tint(Color("selectedTabItem"))
            .globalBackground()
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.filterFavoriteHerbs(with: searchText, filters: selectedFilters)
            }
            .onChange(of: selectedFilters) {
                viewModel.filterFavoriteHerbs(with: searchText, filters: selectedFilters)
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(isPresented: $showFilterSheet, selectedFilters: $selectedFilters)
            }
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    FavoritesListView()
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
