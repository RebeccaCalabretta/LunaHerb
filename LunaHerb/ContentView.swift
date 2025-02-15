//
//  ContentView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 11.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("herbalTreatment")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
