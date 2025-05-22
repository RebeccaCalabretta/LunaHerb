//
//  NotificationManager.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 06.03.25.
//

import Foundation
import NotificationCenter
import UIKit

@Observable
final class NotificationManager {
    static let shared = NotificationManager()
    
    let center = UNUserNotificationCenter.current()
    
    var isAuthorized: Bool?
    var errorMessage: String?
    
    private let defaults = UserDefaults.standard
    private let defaultPushTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
    
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
                Task {
                    cancelAllNotifications()
                }
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
    
    var showSettingsAlert: Bool {
        get { UserDefaults.standard.bool(forKey: "showSettingsAlert") }
        set { UserDefaults.standard.set(newValue, forKey: "showSettingsAlert") }
    }
    
    func requestNotificationAuthorization() async -> Bool {
        do {
            let success = try await center.requestAuthorization(options: [.sound, .alert, .badge])
            await MainActor.run {
                isPushEnabled = success
            }
            return success
        } catch {
            errorMessage = error.localizedDescription
            await MainActor.run {
                isPushEnabled = false
            }
            return false
        }
    }
    
    func checkAuthStatus() async {
        let settings = await center.notificationSettings()
        if settings.authorizationStatus == .denied {
            await MainActor.run {
                isPushEnabled = false
                showSettingsAlert = true
            }
        }
    }
    
    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func scheduleReminderNotification(for reminder: Reminder) {
        guard isPushEnabled else { return }
        let validPushTime = pushTime

        scheduleNotification(
            message: reminder.message,
            date: reminder.date,
            validPushTime: validPushTime,
            id: reminder.id.uuidString
        )
        [reminderDays1, reminderDays2]
            .compactMap { $0 }
            .filter { $0 != 0 }
            .forEach { daysBefore in
                if let newDate = Calendar.current.date(byAdding: .day, value: -daysBefore, to: reminder.date) {
                    let message = createReminderMessage(for: reminder, daysBefore: daysBefore)
                    let combinedID = reminder.id.uuidString + "-\(daysBefore)"
                    scheduleNotification(
                        message: message,
                        date: newDate,
                        validPushTime: validPushTime,
                        id: combinedID
                    )
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
    
    private func scheduleNotification(message: String, date: Date, validPushTime: Date, id: String) {
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
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

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
    
    func removePendingNotification(for id: UUID) async {
        let allPending = await center.pendingNotificationRequests()
        let allDelivered = await center.deliveredNotifications()

        let matchingPending = allPending.filter { $0.identifier.contains(id.uuidString) }
        let matchingDelivered = allDelivered.filter { $0.request.identifier.contains(id.uuidString) }

        let matchingIDsPending = matchingPending.map(\.identifier)
        let matchingIDsDelivered = matchingDelivered.map { $0.request.identifier }

        center.removePendingNotificationRequests(withIdentifiers: matchingIDsPending)
        center.removeDeliveredNotifications(withIdentifiers: matchingIDsDelivered)

        if !matchingPending.isEmpty || !matchingDelivered.isEmpty {
            print("✅ Gelöscht: \(matchingIDsPending + matchingIDsDelivered)")
        } else {
            print("ℹ️ Keine Notifications mehr vorhanden für Reminder ID \(id).")
        }
    }

    func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    
    func rescheduleAllNotifications(for reminders: [Reminder]) async {
        cancelAllNotifications()
        
        for reminder in reminders {
            scheduleReminderNotification(for: reminder)
        }
    }
}
