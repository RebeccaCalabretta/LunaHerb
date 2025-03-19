//
//  OnboardingScreen.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.03.25.
//

import SwiftUI

struct OnboardingScreen: View {
    var title: String
    var description: String
    var imageName: String
    var showStartButton: Bool = false
    var action: (() -> Void)?
    @Binding var currentPage: Int
    var totalPages: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 200)
            
            Text(title)
                .font(.custom("Pompiere", size: 28))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(description)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            if showStartButton {
                GeneralButton(title: "Los geht’s") {
                    action?()
                }
            } else {
                GeneralButton(title: "Weiter") {
                    withAnimation {
                        currentPage += 1
                    }
                }
            }
            
            HStack {
                ForEach(0..<totalPages, id: \..self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(currentPage == index ? .white : .gray)
                }
            }
            .padding(.top, 10)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingScreen(
        title: "Test Title",
        description: "Test description for the preview.",
        imageName: "moon_phase",
        currentPage: .constant(0),
        totalPages: 3
    )
}
