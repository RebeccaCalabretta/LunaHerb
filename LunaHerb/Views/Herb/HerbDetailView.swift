//
//  HerbDetailView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 24.02.25.
//

import SwiftUI

struct HerbDetailView: View {
    let herb: HerbData
    
    var body: some View {
        VStack {
            Text(herb.name)
            Text(herb.description)
        }
    }

}

