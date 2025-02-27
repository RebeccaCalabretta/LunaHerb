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
}
