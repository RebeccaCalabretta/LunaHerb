//
//  NotificationManager.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 06.03.25.
//

import Foundation
import NotificationCenter

@Observable
final class NotificationManager {
    static let shared = NotificationManager()
    
    let center = UNUserNotificationCenter.current()
    
    var isAuthorized: Bool?
    var errorMessage: String?
    
    private let defaults = UserDefaults.standard
    private let defaultPushTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
    
    init() {
        printScheduleNotifications()
    }
    
    var pushTime: Date {
        get {
            if let storedTime = defaults.object(forKey: "pushTime") as? Date {
                return storedTime
            }
            return defaultPushTime
        }
        set {
            defaults.set(newValue, forKey: "pushTime")
        }
    }
    
    var isPushEnabled: Bool {
        get { defaults.bool(forKey: "isPushEnabled") }
        set {
            defaults.set(newValue, forKey: "isPushEnabled")
            if newValue {
                Task {
                    await requestNotificationAuthorization()
                }
            } else {
                cancelAllNotifications()
            }
        }
    }
    
    var reminderDays1: Int? {
        get { defaults.object(forKey: "reminderDays1") as? Int }
        set { defaults.set(newValue, forKey: "reminderDays1") }
    }
    
    var reminderDays2: Int? {
        get { defaults.object(forKey: "reminderDays2") as? Int }
        set { defaults.set(newValue, forKey: "reminderDays2") }
    }
    
    func requestNotificationAuthorization() async {
        Task { @MainActor in
            do {
                let success = try await center.requestAuthorization(options: [.sound, .alert, .badge])
                isAuthorized = success
                print("Benachrichtigungsberechtigung: \(isAuthorized ?? false)")
            } catch {
                errorMessage = error.localizedDescription
                print("Fehler bei der Berechtigung: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleReminderNotification(for reminder: Reminder) {
        guard isPushEnabled else {
            print("Benachrichtigungen sind deaktiviert")
            return }
        
        let date = reminder.date
        let calendar = Calendar.current
        
        var validPushTime = pushTime
        //        if calendar.component(.year, from: validPushTime) == 1970 {
        //            print("Warnung: Ungültige Push-Time erkannt. Setze auf aktuelle Zeit.")
        //            validPushTime = Date()
        //        }
        //
        print("Push-Time nach Validierung: \(validPushTime)")
        
        print("Benachrichtigung wird für den \(reminder.message) am \(date) geplant")
        scheduleNotification(message: reminder.message, date: date, validPushTime: validPushTime)
        
        if let days1 = reminderDays1 {
            if let newDate = calendar.date(byAdding: .day, value: -days1, to: date) {
                let message = createReminderMessage(for: reminder, daysRemaining: days1)
                print("Erinnerung 1 wird für den \(message) geplant")
                scheduleNotification(message: message, date: newDate, validPushTime: validPushTime)
            }
        }
        
        if let days2 = reminderDays2, days2 != reminderDays1 {
            if let newDate = calendar.date(byAdding: .day, value: -days2, to: date) {
                let message = createReminderMessage(for: reminder, daysRemaining: days2)
                print("Erinnerung 2 wird für den \(message) geplant")
                scheduleNotification(message: message, date: newDate, validPushTime: validPushTime)
            }
        }
    }
    
    func createReminderMessage(for reminder: Reminder, daysRemaining: Int) -> String {
        let calendar = Calendar.current
        let today = Date()
        let targetDate = calendar.date(byAdding: .day, value: -daysRemaining, to: reminder.date)!
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        
        guard let days = components.day else { return "Fehler bei der Berechnung" }
        
        if days == 1 {
            return "In einem Tag: \(reminder.message)"
        } else if days > 1 {
            return "In \(days) Tagen: \(reminder.message)"
        } else if days == 0 {
            return "Heute: \(reminder.message)"
        }
        return ""
    }
    
    func scheduleNotification(message: String, date: Date, validPushTime: Date) {
        let content = UNMutableNotificationContent()
        content.title = "LunaHerb Erinnerung"
        content.body = message
        content.sound = .default
        
        let calendar = Calendar.current

        let timeComponents = calendar.dateComponents([.hour, .minute], from: validPushTime)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let components = DateComponents(
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day,
            hour: timeComponents.hour,
            minute: timeComponents.minute
        )
        
        
        // Debug-Ausgabe der validierten Push-Time
        print("Benachrichtigung wird mit folgenden Komponenten geplant: year: \(components.year ?? -1) month: \(components.month ?? -1) day: \(components.day ?? -1) hour: \(components.hour ?? -1) minute: \(components.minute ?? -1)")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        scheduleLocalNotification(request)
    }
    
    func printScheduleNotifications() {
        Task {
            let notifications = await center.pendingNotificationRequests()
            print("Pending Notifications: \(notifications)")
        }
        Task {
            let notifications = await center.deliveredNotifications()
            print("Delivered Notifications: \(notifications)")
        }
    }
    
    private func scheduleLocalNotification(_ request: UNNotificationRequest) {
        Task {
            do {
                try await center.add(request)
                print("Benachrichtigung erfolgreich hinzugefügt.")
            } catch {
                errorMessage = error.localizedDescription
                print("Fehler beim Hinzufügen der Benachrichtigung: \(error.localizedDescription)")
            }
            printScheduleNotifications()
        }
    }
    
    func cancelAllNotifications() {
        print("Alle Benachrichtigungen werden entfernt.")
        center.removeAllPendingNotificationRequests()
    }
}
