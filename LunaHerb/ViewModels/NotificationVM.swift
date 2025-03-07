//
//  NotificationVM.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 06.03.25.
//

import Foundation
import NotificationCenter

@Observable
final class NotificationVM {
    
    let center = UNUserNotificationCenter.current()
    
    var isAuthorized: Bool?
    var errorMessage: String?
    
    private let defaults = UserDefaults.standard
    
    var isPushEnabled: Bool {
        get { defaults.bool(forKey: "isPushEnabled") }
        set { defaults.set(newValue, forKey: "isPushEnabled") }
    }
    
    var pushNotification: Int {
        get { defaults.integer(forKey: "pushNotification") }
        set { defaults.set(newValue, forKey: "pushNotification") }
    }
    
    var pushTime: Int {
        get { defaults.integer(forKey: "pushTime") }
        set { defaults.set(newValue, forKey: "pushTime") }
    }
    
    func requestNotificationAuthorization() {
        Task { @MainActor in
            do {
                let success = try await center.requestAuthorization(options: [.sound, .alert, .badge])
                isAuthorized = success
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Mond-Erinnerung"
        content.body = "Heute ist ein besonderer Mondtag!"
        content.sound = .default
        
        var components = DateComponents()
        components.hour = 20
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        scheduleLocalNotification(request)
    }
    
    private func scheduleLocalNotification(_ request: UNNotificationRequest) {
        Task {
            do {
                try await center.add(request)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
