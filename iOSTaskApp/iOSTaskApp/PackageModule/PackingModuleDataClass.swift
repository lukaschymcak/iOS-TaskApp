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
    
    private(set) var name: String
  var percentage:Int {
      if let firstTrip = trips.first {
          return firstTrip.percentage
        }
        return 0
    }
    @Relationship(deleteRule: .cascade)
    private(set) var trips  = [Trip]().sorted(by: {$0.dateTo < $1.dateTo})
    @Relationship(deleteRule: .cascade)
    private(set) var tripHistory  = [Trip]().sorted(by: {$0.dateTo < $1.dateTo})
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
        self.trips = self.trips.sorted(by: {$0.dateTo < $1.dateTo})
    }
   
}


struct PackingMockData{
    static let packingMock = PackingModuleDataClass(name: "Packing",trip: [Trip(id: UUID(), name: "Trip to Italy", dateFrom: Date.now, dateTo: Date.now)])
    
    
    
    static let packingArr = [packingMock]
}


