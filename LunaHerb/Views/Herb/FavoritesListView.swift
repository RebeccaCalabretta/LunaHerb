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
    @State private var showSearch = false

    let spacing: CGFloat = 16
    let horizontalPadding: CGFloat = 16

    var favoriteHerbs: [HerbData] {
        if searchText.isEmpty && selectedFilters.isEmpty {
            return viewModel.getFavoriteHerbs()
        } else {
            return viewModel.filteredFavHerbs
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 2) {
                    if showSearch {
                        HStack(spacing: 6) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Suche", text: $searchText)
                                .onChange(of: searchText) {
                                    viewModel.filterFavoriteHerbs(with: searchText, filters: selectedFilters)
                                }
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)

                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                    viewModel.filteredFavHerbs = viewModel.getFavoriteHerbs()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(10)
                        .background(Color(uiColor: .tertiarySystemFill))
                        .cornerRadius(10)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }

                    Spacer()

                    Button {
                        withAnimation {
                            showSearch.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundStyle(Color("selectedTabItem"))
                    }

                    Button {
                        showFilterSheet = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundStyle(Color("selectedTabItem"))
                            .padding(.leading, 4)
                    }
                }
                .padding(.horizontal)

                if !selectedFilters.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            selectedFilters.removeAll()
                            viewModel.filteredFavHerbs = viewModel.getFavoriteHerbs()
                        } label: {
                            Text("Filter löschen")
                                .font(.headline)
                                .foregroundColor(Color("cancelActions"))
                        }
                    }
                    .padding(.horizontal)
                }

                ScrollView {
                    let screenWidth = UIScreen.main.bounds.width
                    let cardWidth = (screenWidth - (2 * horizontalPadding) - spacing) / 2

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: spacing),
                            GridItem(.flexible(), spacing: spacing)
                        ],
                        spacing: spacing
                    ) {
                        ForEach(favoriteHerbs) { herb in
                            HerbCard(herb: herb)
                                .frame(width: cardWidth, height: cardWidth)
                                .onTapGesture {
                                    selectedHerb = herb
                                }
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, spacing)
                    .padding(.bottom, spacing)
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("FAVORITEN")
                        .font(.custom("AvenirNext-Regular", size: 24))
                        .foregroundColor(Color("titleText"))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedHerb) { herb in
                HerbDetailView(herb: herb)
            }
            .tint(Color("selectedTabItem"))
            .globalBackground()
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(isPresented: $showFilterSheet, selectedFilters: $selectedFilters)
            }
            .onChange(of: selectedFilters) {
                viewModel.filterFavoriteHerbs(with: searchText, filters: selectedFilters)
            }
            .onAppear {
                searchText = ""
                showSearch = false
            }
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    FavoritesListView()
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
