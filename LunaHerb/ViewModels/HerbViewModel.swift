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
    }
    
    func filterFavoriteHerbs(with query: String, filters: Set<String>) {
        let trimmedFilters = filters.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        let filtersSet = Set(trimmedFilters)

        filteredHerbs = herbs.filter { herb in
            guard herb.isFavorite else { return false }

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
    }
}
