//
//  HerbViewModel.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import Foundation

@MainActor
@Observable
final class HerbViewModel {
    
    var herbs: [HerbData] = []
    var filteredHerbs: [HerbData] = []
    var selectedFilters: Set<String> = []
    
    private var repository = HerbRepository()
    
    init() {
        Task {
            await fetchHerbs()
        }
    }
    
    func fetchHerbs() async {
        do {
            self.herbs = try await repository.loadHerbsFromFile()
        } catch {
            print("Fehler beim Laden der Kräuterdaten")
        }
    }
    
    func toggleFavorite(for herb: HerbData) async {
        guard let index = herbs.firstIndex(where: { $0.id == herb.id }) else { return }
        herbs[index].isFavorite.toggle()
    }
    
    func getFavoriteHerbs() -> [HerbData] {
        return herbs.filter { $0.isFavorite }
    }
    
    func filterHerbs(with query: String, filters: Set<String>) {
        filteredHerbs = herbs.filter { herb in
            let matchingSearchQuery = query.isEmpty ||
            herb.name.lowercased().contains(query.lowercased()) ||
            herb.properties.contains { $0.lowercased().contains(query.lowercased()) }
            
            let matchingFilters = filters.isEmpty || filters.isSubset(of: Set(herb.properties.map { $0.lowercased() }))
            
            return matchingSearchQuery && matchingFilters
        }
    }
}
