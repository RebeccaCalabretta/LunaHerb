//
//  MainView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 15.02.25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(HerbVM.self) private var herbVM
    @Environment(MoonVM.self) private var moonVM

    var body: some View {
            MainTabView()
            .environment(\.modelContext, modelContext)
            .environment(moonVM)
            .environment(herbVM)
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: HerbData.self)
    MainView()
        .environment(MoonVM())
        .environment(HerbVM(modelContext: modelContainer.mainContext)) 
}
