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
//        .onAppear {
//            print("⚡️ WeatherView onAppear - Starte initialen API-Call")
//            print("🔍 Aktuelles Datum (selectedDate): \(selectedDate)")
//            print("📍 Aktueller Standort: \(location)")
//            
//            Task {
//                if let locationCL = await weatherVM.getCLLocation(from: location) {
//                    print("✅ Standort gefunden: \(locationCL)")
//                    await weatherVM.getWeather(for: selectedDate, location: locationCL)
//                } else {
//                    print("❌ Fehler beim Abrufen des Standorts für \(location)")
//                }
//            }
//        }
//        .onChange(of: location) { newLocation in
//            print("📍 onChange - location geändert: \(newLocation)")
//            
//            Task {
//                if let locationCL = await weatherVM.getCLLocation(from: newLocation) {
//                    print("✅ Neuer Standort gefunden: \(locationCL)")
//                    await weatherVM.getWeather(for: selectedDate, location: locationCL)
//                } else {
//                    print("❌ Fehler beim Abrufen des Standorts für \(newLocation)")
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    WeatherView(
//        selectedDate: .constant(Date()), location: .constant("Berlin"),
//        weatherVM: WeatherVM()
//    )
//}
