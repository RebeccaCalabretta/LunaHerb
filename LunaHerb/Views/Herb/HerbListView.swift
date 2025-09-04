//
//  HerbListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.02.25.
//

import SwiftUI
import SwiftData

struct HerbListView: View {
    @Environment(HerbVM.self) private var viewModel
    @Query(sort: \HerbData.name) var herbs: [HerbData]
    
    @State private var searchText = ""
    @State private var selectedFilters: Set<String> = []
    @State private var showFilterSheet = false
    @State private var showReminderList = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var herbsToShow: [HerbData] {
        searchText.isEmpty && selectedFilters.isEmpty ? viewModel.herbs : viewModel.filteredHerbs
    }
    
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
                                .foregroundColor(Color("cancelActions"))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 4)
                
                ScrollView {
                    let spacing: CGFloat = 16
                    let horizontalPadding: CGFloat = 16
                    let screenWidth = UIScreen.main.bounds.width
                    let cardWidth = (screenWidth - (2 * horizontalPadding) - spacing) / 2
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(herbsToShow) { herb in
                            NavigationLink(value: herb.id) {
                                HerbCard(herb: herb)
                                    .frame(width: cardWidth, height: cardWidth)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, spacing)
                    .padding(.bottom, spacing)
                }
            }
            .onAppear {
                searchText = ""
                Task { await viewModel.fetchHerbs() }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(isPresented: $showFilterSheet, selectedFilters: $selectedFilters)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("KRÄUTER")
                        .font(.custom("AvenirNext-Regular", size: 24))
                        .foregroundColor(Color("titleText"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showReminderList = true } label: {
                        Image(systemName: "bell")
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showReminderList) {
                ReminderListView()
            }
            .navigationDestination(for: UUID.self) { id in
                if let herb = herbs.first(where: { $0.id == id }) {
                    HerbDetailView(herb: herb)
                }
            }
            .tint(Color("selectedTabItem"))
            .globalBackground()
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.filterHerbs(with: searchText, filters: selectedFilters)
            }
            .alert("Fehler", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
}


#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    HerbListView()
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
