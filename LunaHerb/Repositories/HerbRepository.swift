//
//  HerbRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import Foundation

@Observable
final class HerbRepository {
    
    func loadHerbsFromFile() async throws -> [HerbData] {
        guard let url = Bundle.main.url(forResource: "herbs", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        let herbs = try JSONDecoder().decode([HerbData].self, from: data)
        return herbs
    }
}
