//
//  Settings.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 09.03.25.
//

import Foundation
import SwiftData

@Model
final class Settings {
    var isPushEnabled: Bool
    var pushTime: Date
    var isDarkModeEnabled: Bool
    var reminderDays1: Int?
    var reminderDays2: Int?

    init(isPushEnabled: Bool = false, pushTime: Date = Date(), isDarkModeEnabled: Bool = false, reminderDays1: Int? = nil, reminderDays2: Int? = nil) {
        self.isPushEnabled = isPushEnabled
        self.pushTime = pushTime
        self.isDarkModeEnabled = isDarkModeEnabled
        self.reminderDays1 = reminderDays1
        self.reminderDays2 = reminderDays2
    }
}
