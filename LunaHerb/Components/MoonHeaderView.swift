//
//  MoonHeaderView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 28.02.25.
//

import SwiftUI

struct MoonHeaderView: View {
    
    @Binding var selectedDate: Date
    @Binding var viewModel: MoonViewModel
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(Color("text"))
                .padding(.leading)
                .onTapGesture {
                    Task {
                        await viewModel.changeDay(by: -1)
                    }
                }
            MoonCard(viewModel: $viewModel)
            Image(systemName: "chevron.right")
                .font(.title)
                .foregroundColor(Color("text"))
                .padding(.trailing)
                .onTapGesture {
                    Task {
                        await viewModel.changeDay(by: 1)
                    }
                }
        }
    }
}
