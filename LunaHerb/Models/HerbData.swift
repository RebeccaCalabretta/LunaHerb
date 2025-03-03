//
//  HerbData.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 23.02.25.
//

import Foundation

struct HerbData: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var description: String
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
}
