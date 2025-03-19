//
//  MoonChevronNavigation.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 14.03.25.
//

import SwiftUI

struct MoonChevronNavigation: View {
    @Binding var moonVM: MoonVM
    @Binding var selectedDate: Date
    @Binding var scrollPosition: Date?
    @State private var showCreateReminder = false
    
    let dates: [Date]
    
    var body: some View {
        HStack {
            Button(action: { MoonChevronHelper.scrollBackward(dates: dates, selectedDate: $selectedDate, scrollPosition: $scrollPosition) }) {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color("selectedTabItem"))
                    .padding(10)
            }
            
            Spacer()
            
            Button(action: { showCreateReminder = true }) {
                Image(systemName: "bell.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color("selectedTabItem"))
                    .padding(10)
            }
            .sheet(isPresented: $showCreateReminder) {
                CreateReminder(reminder: .constant(nil), defaultDate: selectedDate)
                    .presentationDetents([.medium])
            }
            
            Spacer()
            
            Button(action: { MoonChevronHelper.scrollForward(dates: dates, selectedDate: $selectedDate, scrollPosition: $scrollPosition) }) {
                Image(systemName: "chevron.right.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color("selectedTabItem"))
                    .padding(10)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
}

