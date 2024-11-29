//
//  NotificationService.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/11/2024.
//

import Foundation
import SwiftUI

@MainActor
final class NotificationService : ObservableObject {
     var isNotificationForPlantsOn = false
      var isNotificationForPackingOn = false
      var contentPacking = UNMutableNotificationContent()
      var packingNotifCreated = false
    
    static let shared = NotificationService()
    private init() {}

    func setPlantsNotifOn(){
        isNotificationForPlantsOn = true
    }
    func setPlantsNotifOff(){
        isNotificationForPlantsOn = false
    }
    
    func setPackageNotifOn(){
        isNotificationForPackingOn = true
    }
    func setPackageNotifOff(){
        isNotificationForPackingOn = false
    }
    
    func createPackingNotification(for tripName:String, left days:Int, percentage : Int) {
   
        self.contentPacking.title = "\(tripName) is coming in \(days) days"
        self.contentPacking.body = "Don't forget to pack your stuff, you are \(percentage)% ready"
        self.contentPacking.sound = UNNotificationSound.default
        packingNotifCreated = true
            
    
   
    }
    
    func sendNotification(for notif:UNMutableNotificationContent,when:DateComponents){
        let trigger = UNCalendarNotificationTrigger(dateMatching: when, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notif, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        packingNotifCreated = false
    }
    
    func updateBadges(for notif:UNMutableNotificationContent){
        notif.badge = 0 
    
    }
    
    func getPackingNotifData() -> UNMutableNotificationContent {
        return contentPacking
    }
    
    func resetAllNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
