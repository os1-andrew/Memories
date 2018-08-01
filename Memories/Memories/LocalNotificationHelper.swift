//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Andrew Liao on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Good morning."
        content.body =  "Start your day by creating a memory!"
        content.sound = UNNotificationSound.default()
        
        let hour = DateComponents(hour: 20)
        let trigger = UNCalendarNotificationTrigger(dateMatching: hour, repeats: true)
      
        let request = UNNotificationRequest(identifier: "morningMemoryNotification", content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
        //DO I NEED THE error handling here?
    }
    
}
