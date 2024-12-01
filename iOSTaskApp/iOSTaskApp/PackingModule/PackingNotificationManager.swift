//
//  PackingNotificationManager.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 30/11/2024.
//

import Foundation
import UserNotifications

class PackingNotificationManager {
    var content = UNMutableNotificationContent()
    var packingNotifCreated = false
    var isPackingNotfiOn: Bool {
        return UserDefaults.standard.bool(forKey: "packingNotif")
    }
    
    static let shared = PackingNotificationManager()
    private init(){}
    
    
    func checkAndcreatePackingNotifications(for module : PackingModuleViewModel ){
        guard let module = module.selectedModule else { return}
        guard let trip = module.earliestTrip else {return }
        guard isPackingNotfiOn && trip.dayDifference <= 3  else { print("Notification not prepared \(isPackingNotfiOn.description) \(trip.dayDifference)")
            return }
        
        print("Notification prepared \(isPackingNotfiOn.description) \(trip.dayDifference) ")
        var date = DateComponents()
        date.hour = 12
        date.minute = 0
        let identifier = "Trip Notification"
        self.content.title = "Task App"
        self.content.subtitle = trip.dateFrom.isToday()  ? "Trip \(trip.name) is happening today" : "Trip \(trip.name) is in \(trip.dayDifference) days"
        self.content.body = "You are \(trip.percentage)% ready"
        self.content.sound = UNNotificationSound.default
        self.content.badge = 1
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: self.content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
                                                                          
                                                                        
       
       
        
    }
    
    
    
    


