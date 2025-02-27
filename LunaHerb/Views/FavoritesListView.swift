//
//  FavoritesListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI

struct FavoritesListView: View {
    @Environment(HerbViewModel.self) private var viewModel
    @State private var searchText = ""
    @State private var selectedHerb: HerbData? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Suche nach favorisierten Kräutern...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.getFavoriteHerbs()) { herb in
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
            .navigationDestination(item: $selectedHerb) { herb in
                HerbDetailView(herb: herb)
            }
            .tint(Color("selectedTabItem"))
            .globalBackground()
        }
    }
}

#Preview {
    FavoritesListView()
        .environment(HerbViewModel())
}
