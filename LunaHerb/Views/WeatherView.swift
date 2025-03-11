////
////  WeatherView.swift
////  LunaHerb
////
////  Created by Rebecca Calabretta on 10.03.25.
////
//
//import SwiftUI
//
//struct WeatherView: View {
//
//    @Binding var selectedDate: Date
//    @Binding var location: String
//    var weatherVM: WeatherVM
//    var moonVM: MoonVM
//
//    var body: some View {
//        VStack {
//            if weatherVM.temperature != "--" {
//                HStack {
//                    Image(systemName: weatherVM.sfSymbol)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//
//                    Text("\(weatherVM.temperature)")
//                        .font(.title2)
//                }
//                .foregroundStyle(Color("text"))
//                .padding()
//            } else {
//                ProgressView()
//            }
//        }
//        .padding()
//                .onAppear {
//Task {
//    await weatherVM.getWeather(for: selectedDate)
//}
//}
//.onChange(of: moonVM.selectedDate) { oldValue, newValue in
//    Task {
//        await weatherVM.getWeather(for: newValue)
//    }
//}
//    }
//}
//
//#Preview {
//    WeatherView(
//        selectedDate: .constant(Date()), location: .constant("Berlin"),
//        weatherVM: WeatherVM(),
//        moonVM: MoonVM()
//    )
//}
