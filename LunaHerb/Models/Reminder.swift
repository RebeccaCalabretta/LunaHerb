//
//  Reminder.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import Foundation

struct Reminder: Identifiable {
    var id: UUID = UUID()
    var message: String
    var date: Date
}
