//
//  MoonChevronHelper.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 18.03.25.
//

import SwiftUI

struct MoonChevronHelper {
    static func scrollBackward(dates: [Date], selectedDate: Binding<Date>, scrollPosition: Binding<Date?>) {
        if let currentIndex = dates.firstIndex(of: selectedDate.wrappedValue), currentIndex > 0 {
            let newDate = dates[currentIndex - 1]
            withAnimation {
                scrollPosition.wrappedValue = newDate
            }
        }
    }

    static func scrollForward(dates: [Date], selectedDate: Binding<Date>, scrollPosition: Binding<Date?>) {
        if let currentIndex = dates.firstIndex(of: selectedDate.wrappedValue), currentIndex < dates.count - 1 {
            let newDate = dates[currentIndex + 1]
            withAnimation {
                scrollPosition.wrappedValue = newDate
            }
        }
    }
}

