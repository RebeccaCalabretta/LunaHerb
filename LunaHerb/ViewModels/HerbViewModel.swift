//
//  HerbViewModel.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import Foundation

@Observable
class HerbViewModel {
    var herbs: [HerbData] = []
    private var repository = HerbRepository()
    
    init() {
        Task {
            await fetchHerbs()
        }
    }
    
    func fetchHerbs() async {
        do {
            try await repository.loadHerbsFromFile()
        } catch {
            print("Fehler beim Laden der Kräuterdaten")
        }
    }
     
}
