//
//  WeatherView.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 10.03.25.
//
import SwiftUI

struct WeatherView: View {
    @Bindable var weatherVM: WeatherVM
    
    var body: some View {
        VStack {
            if weatherVM.temperature != "--" {
                HStack {
                    Image(systemName: weatherVM.sfSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 8)
                    
                    Text("\(weatherVM.temperature)")
                        .frame(width: 50)
                        .font(.system(size: 18))
                        .padding(.trailing, 8)
                }
                .foregroundStyle(Color("cardText"))
                .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
