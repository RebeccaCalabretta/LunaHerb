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
    @State private var selectedHerb: HerbData? = nil
    @State private var selectedFilters: Set<String> = []
    @State private var showFilterSheet = false
    @State private var showReminderList = false

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
                                .foregroundColor(Color("cancelActions"))
                        }
                        .padding(.trailing, 5)
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        if searchText.isEmpty && selectedFilters.isEmpty {
                            ForEach(viewModel.herbs) { herb in
                                HerbCard(herb: herb)
                                    .onTapGesture {
                                        selectedHerb = herb
                                    }
                            }
                        } else {
                            ForEach(viewModel.filteredHerbs) { herb in
                                HerbCard(herb: herb)
                                    .onTapGesture {
                                        selectedHerb = herb
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                searchText = ""
                Task {
                    await viewModel.fetchHerbs()
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(isPresented: $showFilterSheet, selectedFilters: $selectedFilters)
            }
            .navigationTitle("Kräuter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showReminderList = true
                        } label: {
                            Image(systemName: "bell")
                        }
                    }
                    .font(.headline)
                }
            }
            .navigationDestination(isPresented: $showReminderList) {
                ReminderListView()
            }
            .navigationDestination(item: $selectedHerb) { herb in
                HerbDetailView(herb: herb)
            }
            .tint(Color("selectedTabItem"))
            .globalBackground()
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.filterHerbs(with: searchText, filters: selectedFilters)
            }
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    HerbListView()
        .environment(HerbVM(modelContext: modelContainer.mainContext))
}
