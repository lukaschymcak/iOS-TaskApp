//
//  PackingNotificationManager.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 30/11/2024.
//

import Foundation
import UserNotifications
import SwiftUI

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
        guard isPackingNotfiOn && trip.dayDifference <= 3 && trip.percentage < 100  else { print("Notification not prepared")
            return }
        
        print("Notification prepared")
        var date = DateComponents()
        date.hour = 12
        date.minute = 0
        let identifier = "TripNotification"
        self.content.title = "Task App"
        self.content.subtitle = trip.dateFrom.isToday()  ? NSLocalizedString("\(trip.name) is happening today", comment: "") :NSLocalizedString("\(trip.name) is happening in \(trip.dayDifference) day", comment: "")
        self.content.body =   NSLocalizedString("You are \(trip.percentage)% ready", comment: "")
        self.content.sound = UNNotificationSound.default
        self.content.badge = 1
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: self.content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeTripNotificationfromCenter(){
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TripNotification"])
    }
                                                                          
                                                                        
       
       
        
    }
    
    
    
    


