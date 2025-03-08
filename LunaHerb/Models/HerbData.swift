//
//  HerbData.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 23.02.25.
//

import Foundation
import SwiftData

@Model
final class HerbData {
    var id: UUID
    var name: String
    var detail: String
    var asyncImageURL: URL
    var properties: [String]
    var effect: String
    var usage: [String]
    var symptoms: [String]
    var ingredients: [String]
    var sideEffects: [String]?
    var contraindications: [String]?
    var harvestTime: [String]
    var harvest: String?
    var isFavorite: Bool = false
    
    init(id: UUID, name: String, detail: String, asyncImageURL: URL, properties: [String], effect: String, usage: [String], symptoms: [String], ingredients: [String], sideEffects: [String]? = nil, contraindications: [String]? = nil, harvestTime: [String], harvest: String? = nil, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.detail = detail
        self.asyncImageURL = asyncImageURL
        self.properties = properties
        self.effect = effect
        self.usage = usage
        self.symptoms = symptoms
        self.ingredients = ingredients
        self.sideEffects = sideEffects
        self.contraindications = contraindications
        self.harvestTime = harvestTime
        self.harvest = harvest
        self.isFavorite = isFavorite
    }
    
    static func fromDTO(_ dto: HerbDataJson) -> HerbData {
        return HerbData(
            id: dto.id,
            name: dto.name,
            detail: dto.description,
            asyncImageURL: dto.asyncImageURL,
            properties: dto.properties,
            effect: dto.effect,
            usage: dto.usage,
            symptoms: dto.symptoms,
            ingredients: dto.ingredients,
            sideEffects: dto.sideEffects,
            contraindications: dto.contraindications,
            harvestTime: dto.harvestTime,
            harvest: dto.harvest,
            isFavorite: dto.isFavorite
        )
    }
}
