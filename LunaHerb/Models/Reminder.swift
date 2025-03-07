//
//  Reminder.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import Foundation
import SwiftData

@Model
final class Reminder {
    var id: UUID
    var message: String
    var date: Date
    
    init(id: UUID = UUID(), message: String, date: Date) {
        self.id = id
        self.message = message
        self.date = date
    }
}
