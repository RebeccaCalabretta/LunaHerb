//
//  HerbDataExtensions.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 26.02.25.
//

import Foundation

extension HerbData {
    
    func toDescriptionViewModel() -> DescriptionViewModel {
        return DescriptionViewModel(
            description: self.description,
            ingredients: self.ingredients,
            harvestTime: self.harvestTime,
            harvest: self.harvest
        )
    }
    
    func toEffectsViewModel() -> EffectsViewModel {
        return EffectsViewModel(
            effect: self.effect,
            properties: self.properties
        )
    }
    
    func toUsageViewModel() -> UsageViewModel {
        return UsageViewModel(
            symptoms: self.symptoms,
            usage: self.usage
        )
    }
}
