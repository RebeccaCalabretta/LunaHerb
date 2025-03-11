//
//  MoonHeaderView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 28.02.25.
//

import SwiftUI

struct MoonHeaderView: View {
    
    let moonData: MoonData
    @Binding var selectedDate: Date
    @Binding var viewModel: MoonVM
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(Color("text"))
                .padding(.leading)
                .onTapGesture {
                         viewModel.changeDay(by: -1)
                }
            MoonCard(moonData: moonData)
            Image(systemName: "chevron.right")
                .font(.title)
                .foregroundColor(Color("text"))
                .padding(.trailing)
                .onTapGesture {
                        viewModel.changeDay(by: 1)
                }
        }
    }
}
