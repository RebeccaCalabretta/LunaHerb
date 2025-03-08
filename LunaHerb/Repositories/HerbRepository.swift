//
//  HerbRepository.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import Foundation
import SwiftData

@Observable
final class HerbRepository {
    let modelContext: ModelContext
    var errorMessage: String?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func updateHerbsFromDropbox() async throws -> [HerbData] {
        guard let url = URL(string: "https://www.dropbox.com/scl/fi/u9gde3ow3wd4vpetwnax7/herbs.json?rlkey=3gzmvo0ds2wopkcmhau3edivp&st=dxe8cq8b&dl=1") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let dtos = try JSONDecoder().decode([HerbDataJson].self, from: data)
        
        await updateSwiftData(with: dtos)
        return try await loadHerbs()
    }
    
    private func loadHerbs() async throws -> [HerbData] {
        let fetchRequest = FetchDescriptor<HerbData>()
        let herbs = try await modelContext.fetch(fetchRequest)
        return herbs
    }
    
    private func updateSwiftData(with dtos: [HerbDataJson]) async {
        do {
            let existingHerbs = try modelContext.fetch(FetchDescriptor<HerbData>())
            
            for dto in dtos {
                if let existingHerb = existingHerbs.first(where: { $0.id == dto.id }) {
                    existingHerb.name = dto.name
                    existingHerb.detail = dto.description
                    existingHerb.asyncImageURL = dto.asyncImageURL
                    existingHerb.properties = dto.properties
                    existingHerb.effect = dto.effect
                    existingHerb.usage = dto.usage
                    existingHerb.symptoms = dto.symptoms
                    existingHerb.ingredients = dto.ingredients
                    existingHerb.sideEffects = dto.sideEffects
                    existingHerb.contraindications = dto.contraindications
                    existingHerb.harvestTime = dto.harvestTime
                    existingHerb.harvest = dto.harvest
                } else {
                    let newHerb = HerbData.fromDTO(dto)
                    modelContext.insert(newHerb)
                }
            }
            
            try modelContext.save()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
