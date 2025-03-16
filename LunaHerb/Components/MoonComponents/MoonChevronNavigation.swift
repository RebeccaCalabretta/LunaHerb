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
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        moonVM.changeDay(by: -1)
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color("selectedTabItem"))
                            .padding(10)
                    }
                    Spacer()
                    Button(action: {
                        moonVM.changeDay(by: 1)
                    }) {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color("selectedTabItem"))
                            .padding(10)
                    }
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
    }
}

