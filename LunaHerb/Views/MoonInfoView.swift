//
//  MoonInfoView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 14.03.25.
//

import SwiftUI

struct MoonInfoView: View {
    var moonData: MoonData
    @Binding var selectedDate: Date
    @Binding var moonVM: MoonVM
    var colorScheme: ColorScheme

    var body: some View {
        MoonCard(moonData: moonData)
            .padding(.bottom)

        ScrollView {
            LazyVStack(spacing: 16) {
                MoonSectionView(
                    title: "günstig",
                    icon: "checkmark.circle.fill",
                    color: .favorableTitle,
                    actions: moonData.favorable ?? [],
                    weekdayActions: moonData.favorableWeekdayActions ?? [],
                    colorScheme: colorScheme
                )
                MoonSectionView(
                    title: "ungünstig",
                    icon: "xmark.circle.fill",
                    color: .unfavorableTitle,
                    actions: moonData.unfavorable ?? [],
                    weekdayActions: moonData.unfavorableWeekdayActions ?? [],
                    colorScheme: colorScheme
                )
            }
        }
    }
}

