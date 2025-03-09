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
        let trimmedFilters = Set(filters.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
        
        filteredHerbs = herbs.filter { herb in
            let matchQuery = { (string: String) -> Bool in
                return query.isEmpty || string.localizedCaseInsensitiveContains(query)
            }
            
            let matchingSearchQuery = matchQuery(herb.name) ||
                herb.properties.contains { matchQuery($0) } ||
                herb.symptoms.contains { matchQuery($0) } ||
                herb.ingredients.contains { matchQuery($0) }
            
            let herbPropertiesSet = Set(herb.properties.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
            let matchingFilters = trimmedFilters.isEmpty || trimmedFilters.isSubset(of: herbPropertiesSet)
            
            return matchingSearchQuery && matchingFilters
        }
        .sorted { $0.name < $1.name }
    }
    
    func filterFavoriteHerbs(with query: String, filters: Set<String>) {
        filterHerbs(with: query, filters: filters)
        filteredFavHerbs = filteredHerbs.filter { $0.isFavorite }
    }
}
