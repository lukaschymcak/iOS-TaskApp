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
    let mockTripModule = PackingModuleDataClass()
    let sampleTrips = [Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now + 5),Trip(name: "Bratislava", dateFrom: Date.now, dateTo: Date.now)]


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
    
}
