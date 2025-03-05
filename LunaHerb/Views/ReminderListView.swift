//
//  ReminderListView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 05.03.25.
//

import SwiftUI

struct ReminderListView: View {
    
    @Environment(\.colorScheme) var colorScheme

    @State var showCreateReminder = false
    @Environment(ReminderVM.self) private var viewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                Section(header: Text("Bevorstehende Erinnerungen").font(.headline)) {
                    ForEach(viewModel.reminders.filter { $0.date > Date() }
                            .sorted { $0.date < $1.date }) { notification in
                        ReminderSectionView(reminder: notification, colorScheme: colorScheme)
                    }
                }
                Section(header: Text("Vergangene Erinnerungen").font(.headline)) {
                    ForEach(viewModel.reminders.filter { $0.date <= Date() }
                            .sorted { $0.date > $1.date }) { notification in
                        ReminderSectionView(reminder: notification, colorScheme: colorScheme)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Erinnerungen")
        .toolbar {
            Button {
                showCreateReminder = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showCreateReminder) {
            CreateReminder()
                .presentationDetents([.medium])
        }
        .globalBackground()
    }
}

#Preview {
    ReminderListView()
        .environment(ReminderVM())
}
