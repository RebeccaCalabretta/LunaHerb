//
//  OnboardingView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.03.25.
//

import SwiftUI
import SwiftData

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            Color("darkBlue")
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $currentPage) {
                OnboardingScreen(title: "Erlebe die Kraft der Natur im Rhythmus des Mondes",
                                 description: "Erhalte wertvolle Infos zu Ernte, Aussaat und Pflanzenpflege nach dem Mondkalender.",
                                 imageName: "moon_phase",
                                 currentPage: $currentPage,
                                 totalPages: 3)
                .tag(0)
                
                OnboardingScreen(title: "Kräuterdatenbank",
                                 description: "Finde ausführliche Informationen zu Wirkungen, Anwendungen und Anwendungsgebieten verschiedenster Kräuter.",
                                 imageName: "herbalTreatment",
                                 currentPage: $currentPage,
                                 totalPages: 3)
                .tag(1)
                
                OnboardingScreen(title: "Erinnerungsfunktion",
                                 description: "Verpasse keine wichtigen Termine mehr für Aussaat, Ernte oder Pflege deiner Pflanzen.",
                                 imageName: "reminder",
                                 showStartButton: true,
                                 action: { hasSeenOnboarding = true },
                                 currentPage: $currentPage,
                                 totalPages: 3
                )
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            VStack {
                HStack {
                    Spacer()
                    Button("Überspringen") {
                        hasSeenOnboarding = true
                    }
                    .foregroundColor(Color("pastelGreen"))
                    .padding()
                }
                Spacer()
            }
        }
    }
}





#Preview {
    OnboardingView()
}
