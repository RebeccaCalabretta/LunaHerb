//
//  HerbVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class HerbVM {
    
    var herbs: [HerbData] = []
    var filteredHerbs: [HerbData] = []
    var filteredFavHerbs: [HerbData] = []
    var selectedFilters: Set<String> = []
    var errorMessage: String?
    
    private var repository: HerbRepository
    
    init(modelContext: ModelContext) {
        self.repository = HerbRepository(modelContext: modelContext)
        Task {
            await fetchHerbs()
        }
    }
    func fetchHerbs() async {
        do {
            self.herbs = try await repository.updateHerbsFromDropbox()
        } catch {
            print("Fehler beim Laden der Kräuterdaten")
        }
    }
    
    func toggleFavorite(for herb: HerbData) async {
        guard let index = herbs.firstIndex(where: { $0.id == herb.id }) else { return }
        
        herbs[index].isFavorite.toggle()
        
        await repository.saveFavoriteStatus(for: herbs[index])
        await fetchHerbs()
    }
    
    func getFavoriteHerbs() -> [HerbData] {
        return herbs.filter { $0.isFavorite }.sorted { $0.name < $1.name }
    }
    
    func filterHerbs(with query: String, filters: Set<String>) {
        let trimmedFilters = filters.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        let filtersSet = Set(trimmedFilters)
        
        filteredHerbs = herbs.filter { herb in
            let matchingSearchQuery = query.isEmpty ||
            herb.name.localizedCaseInsensitiveContains(query) ||
            herb.properties.contains { $0.localizedCaseInsensitiveContains(query) } ||
            herb.symptoms.contains { $0.localizedCaseInsensitiveContains(query) } ||
            herb.ingredients.contains { $0.localizedCaseInsensitiveContains(query) }
            
            let herbPropertiesSet = Set(herb.properties.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
            
            let matchingFilters: Bool
            if filtersSet.isEmpty {
                matchingFilters = true
            } else {
                matchingFilters = filtersSet.isSubset(of: herbPropertiesSet)
            }
            return matchingSearchQuery && matchingFilters
        }
        .sorted { $0.name < $1.name }
    }
    
    func filterFavoriteHerbs(with query: String, filters: Set<String>) {
        filterHerbs(with: query, filters: filters)
        filteredFavHerbs = filteredHerbs.filter { $0.isFavorite }
    }
}
