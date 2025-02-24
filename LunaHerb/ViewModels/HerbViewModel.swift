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
     
}
