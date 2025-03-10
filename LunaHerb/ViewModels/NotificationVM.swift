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
    
    var pushTime: Date {
        get {
            let timeInterval = defaults.integer(forKey: "pushTime")
            return Date(timeIntervalSince1970: TimeInterval(timeInterval))
        }
        set {
            defaults.set(Int(newValue.timeIntervalSince1970), forKey: "pushTime")
        }
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
    
    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "LunaHerb Erinnerung"
        content.body = reminder.message
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: pushTime)
        
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
