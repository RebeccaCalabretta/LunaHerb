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
            return
        }
        
        let validPushTime = pushTime
        scheduleNotification(message: reminder.message, date: reminder.date, validPushTime: validPushTime)
        
        [reminderDays1, reminderDays2]
            .compactMap { $0 }
            .filter { $0 != 0 }
            .forEach { days in
                if let newDate = Calendar.current.date(byAdding: .day, value: -days, to: reminder.date) {
                    let message = createReminderMessage(for: reminder, daysBefore: days)
                    scheduleNotification(message: message, date: newDate, validPushTime: validPushTime)
                }
            }
    }
    
    private func createReminderMessage(for reminder: Reminder, daysBefore: Int) -> String {
        switch daysBefore {
        case 0: return "Heute: \(reminder.message)"
        case 1: return "Morgen: \(reminder.message)"
        default: return "In \(daysBefore) Tagen: \(reminder.message)"
        }
    }
    
    private func scheduleNotification(message: String, date: Date, validPushTime: Date) {
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
    
    
    // TestPrint
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
    
    func removePendingNotification(for id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    
    func cancelAllNotifications() {
        print("Alle Benachrichtigungen werden entfernt.")
        center.removeAllPendingNotificationRequests()
    }
}
