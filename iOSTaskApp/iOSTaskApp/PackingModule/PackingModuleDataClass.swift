//
//  PackingModuleQuickinfo.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 20/10/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PackingModuleDataClass{
    @Attribute(.unique) var Id: UUID = UUID()
    private(set) var name: String
    var percentage:Int {
        print("perc called")
      if let firstTrip = trips.first {
          return firstTrip.percentage
        }
        return 0
    }
    var dayDifference:Int {
   
        if let earliestTrip = earliestTrip {
            let currentDay = Calendar.current.dateComponents([.day], from: Date())
            let tripDay = Calendar.current.dateComponents([.day], from: earliestTrip.dateFrom)
            return Calendar.current.dateComponents([.day], from: currentDay, to: tripDay).day!
        }
        return 0
    }
    
    var earliestTrip:Trip? {
        if trips.isEmpty {
            return nil
        }
            
        return trips.reduce(trips[0], { $0.dateFrom < $1.dateFrom ? $0 : $1 })
    }
       
    
        
    @Relationship(deleteRule: .cascade)
    private(set) var trips  = [Trip]()
    @Relationship(deleteRule: .cascade)
    private(set) var tripHistory  = [Trip]()
    init(name: String = "Packing",tripHistory:[Trip] = [],trip:[Trip] = []) {
        self.name = name
        self.tripHistory = tripHistory

    }

    func setName(a:String){
        self.name = a
    }
    func addTrip(a:Trip){
        self.trips.append(a)
    }
    func addTripHistory(a:Trip){
        self.tripHistory.append(a)
    }
    func removeTrip(a:Trip){
        if let index = self.trips.firstIndex(of: a){
            self.trips.remove(at: index)
        }
    }
    func removeHistoryTrip(a:Trip){
        if let index = self.tripHistory.firstIndex(of: a){
            self.tripHistory.remove(at: index)
        }
    }
    func sortTrips(){
        self.trips = self.trips.sorted(by: {$0.dateFrom < $1.dateFrom})
    }
   
}


struct PackingMockData{
    static let packingMock = PackingModuleDataClass(name: "Packing",trip: [Trip( name: "Trip to Italy", dateFrom: Date.now, dateTo: Date.now),Trip( name: "Trip to Italy", dateFrom: Date.now, dateTo: Date.now),Trip( name: "Trip to Italy", dateFrom: Date.now, dateTo: Date.now)])
    
    
    
    static let packingArr = [packingMock]
}


