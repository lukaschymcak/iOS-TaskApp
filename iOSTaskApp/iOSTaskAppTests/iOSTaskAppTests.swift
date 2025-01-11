//
//  iOSTaskAppTests.swift
//  iOSTaskAppTests
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import Testing
@testable import TaskApp
import Foundation
import SwiftData
import SwiftUI



@Suite("Packing Module Tests") struct packingModuleTests {
     var context : ModelContext!
    let mockTripModule: TaskApp.PackingModuleDataClass = TaskApp.PackingModuleDataClass()
    let mockTripViewModel = TaskApp.PackingModuleViewModel()
    let mockTripNotificationManager = TaskApp.PackingNotificationManager.shared
    let mockSettingsView = TaskApp.SettingsView()
    let sampleTrips:[TaskApp.Trip] = [TaskApp.Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now + 5),TaskApp.Trip(name: "Bratislava", dateFrom: Date.now + 432000, dateTo: Date.now),TaskApp.Trip(name: "Zilina", dateFrom: Date.now - 86400, dateTo: Date.now + 3)]
    let sampleTripsWithItems: [TaskApp.Trip] = [TaskApp.Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now + 5,bags: [TaskApp.Bags(name: "Bag1",items: [TaskApp.Item(name: "Item", isChecked: true),TaskApp.Item(name:"Item",isChecked: false),TaskApp.Item(name: "Item", isChecked: true)])]),TaskApp.Trip(name: "Bratislava", dateFrom: Date.now + 1, dateTo: Date.now,bags: [TaskApp.Bags(name: "Bag", items: [TaskApp.Item(name: "Item", isChecked: true),TaskApp.Item(name: "Item", isChecked: false)])])]
    


    @Test("Testing if Trips are added correctly") func addPlant()  {
        mockTripModule.addTrip(a:sampleTrips[0])
        mockTripModule.addTrip(a:sampleTrips[1])
        #expect(mockTripModule.trips.count == 2)
    }
    @Test("Testing if Trips are removed correctly") func removePlant() {
        mockTripModule.addTrip(a:sampleTrips[0])
        mockTripModule.addTrip(a:sampleTrips[1])
        if let first = mockTripModule.trips.first {
            mockTripModule.removeTrip(a: first)
        }
        #expect(mockTripModule.trips.count == 1)
    }
    @Test("Testing if trips are added to history") func addHistory() {
        mockTripModule.addTripHistory(a: sampleTrips[0])
        
        #expect(mockTripModule.tripHistory.count == 1)
    }
    
    @Test("Testing if trips are removed from history") func removeHistory() {
        mockTripModule.addTripHistory(a: sampleTrips[0])
        mockTripModule.addTripHistory(a: sampleTrips[1])
        if let first = mockTripModule.tripHistory.first {
            mockTripModule.removeHistoryTrip(a: first)
        }
        #expect(mockTripModule.tripHistory.count == 1)
    }
    
    @Test("Testing if trips are sorted correctly and earliest this is the one with the earliest date") func sortTrips() {
        mockTripModule.addTrip(a: sampleTrips[0])
        mockTripModule.addTrip(a: sampleTrips[1])
        
        #expect(mockTripModule.earliestTrip == sampleTrips[0])
    }
    
    @Test("Testing if percentage of packed items is correct with 1 out of 2 packed") func percentageCheck() {
        mockTripModule.addTrip(a: sampleTripsWithItems[1])
        #expect(mockTripModule.percentage == 50)
        mockTripModule.removeTrip(a: sampleTripsWithItems[1])
        mockTripModule.addTrip(a: sampleTripsWithItems[0])
        #expect(mockTripModule.percentage == 66)
        
    }
    
    @Test("Testing if day difference is set correctly") func dayDifferenceCheck(){
        mockTripModule.addTrip(a: sampleTrips[1]) // Date.now + 432000(5 days)
        #expect(mockTripModule.dayDifference == 5)
        
    }
    
    @Test("Testing if trip is automatically added to history if it is before today") func checkAndAddToHistory() {
        mockTripModule.addTrip(a: sampleTrips[0]) // Date.Now
        mockTripModule.addTrip(a: sampleTrips[2]) // Date.now - 86400
        mockTripViewModel.setSelectedModule(a: mockTripModule)
        mockTripViewModel.checkAndAddToHistory()
        #expect(mockTripModule.trips.count == 1)
        #expect(mockTripModule.tripHistory.count == 1)
        #expect(mockTripModule.trips.first == sampleTrips[0])
        #expect(mockTripModule.tripHistory.first == sampleTrips[2])
    }
    
    @Test("Testing if Packing module is ready for notification is set correclty") func checkIfReadyForNotification() {

        mockTripModule.addTrip(a: sampleTrips[1]) // Date.now + 432000
        mockTripViewModel.setSelectedModule(a: mockTripModule)
        #expect(mockTripViewModel.isReadyForNotification == false)
        mockTripModule.addTrip(a: sampleTrips[0]) // Date.now
        mockTripViewModel.setSelectedModule(a: mockTripModule)
        #expect(mockTripViewModel.isReadyForNotification == true)
        
  
        
    }
    
    @Test("Testing if notification is prepared only when user turns on notification and date is correct") func checkIfNotificationIsCorrectlyTurnedOn() {
        // When date is correct and notification are turned on
        UserDefaults.standard.set(true, forKey: "packingNotif")
        print(mockTripNotificationManager.isPackingNotfiOn)
        mockTripModule.addTrip(a: sampleTrips[0]) // Date.now
        mockTripViewModel.setSelectedModule(a: mockTripModule)
        mockTripNotificationManager.checkAndcreatePackingNotifications(for: mockTripViewModel)
        #expect(mockTripNotificationManager.packingNotifCreated == true)
        UserDefaults.standard.set(false, forKey: "packingNotif")
       
        // When date is correct and notification are turned off
        UserDefaults.standard.set(false, forKey: "packingNotif")
        print(mockTripNotificationManager.isPackingNotfiOn)
        mockTripModule.addTrip(a: sampleTrips[0]) // Date.now
        mockTripViewModel.setSelectedModule(a: mockTripModule)
        mockTripNotificationManager.checkAndcreatePackingNotifications(for: mockTripViewModel)
        #expect(mockTripNotificationManager.packingNotifCreated == false)
        
        // When date is incorrecnt and notification are turned on
        UserDefaults.standard.set(true, forKey: "packingNotif")
        mockTripModule.removeTrip(a: sampleTrips[0])
        mockTripModule.addTrip(a: sampleTrips[1]) // Date.now + 432000
        mockTripNotificationManager.checkAndcreatePackingNotifications(for: mockTripViewModel)
        #expect(mockTripNotificationManager.packingNotifCreated == false)
        UserDefaults.standard.set(false, forKey: "packingNotif")
        
        // When date is incorrecnt and notification are turned off
        UserDefaults.standard.set(false, forKey: "packingNotif")
        mockTripModule.removeTrip(a: sampleTrips[0])
        mockTripModule.addTrip(a: sampleTrips[1]) // Date.now + 432000
        mockTripNotificationManager.checkAndcreatePackingNotifications(for: mockTripViewModel)
        #expect(mockTripNotificationManager.packingNotifCreated == false)

        
        
        
    }
}
