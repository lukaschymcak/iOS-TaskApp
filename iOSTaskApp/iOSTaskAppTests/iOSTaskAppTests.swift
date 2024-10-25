//
//  iOSTaskAppTests.swift
//  iOSTaskAppTests
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import Testing
@testable import iOSTaskApp
import Foundation

@Suite("Packing Module Tests") struct packingModuleTests {
    let packingModel = PackingModuleDataClass(name: "Packing", colorName: "orange" )
    let tripA = Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now)
    @Test("Testing if Packing model is created correctly") func packingModelCreated() async throws {
        
        #expect(packingModel.trips.isEmpty == true)
        #expect(packingModel.tripHistory.isEmpty == true)
        #expect(packingModel.color == .orange)
       
    }
    
    @Test("Testing if trip is added correctly , and if it is removed correctly") func tripTestingAddRemove() async throws {
        
        packingModel.trips.append(tripA)
        #expect(packingModel.trips.contains(tripA))
        if let trip = packingModel.trips.firstIndex(of: tripA){
            packingModel.trips.remove(at: trip)
        }
        #expect(packingModel.trips.contains(tripA) == false)
        
        
    }
    @Test("Testing if tripHistory is added correctly , and if it is removed correctly") func tripHistoryTestingAddRemove() async throws {
        
        packingModel.tripHistory.append(tripA)
        #expect(packingModel.tripHistory.contains(tripA))
        if let trip = packingModel.tripHistory.firstIndex(of: tripA){
            packingModel.tripHistory.remove(at: trip)
        }
        #expect(packingModel.tripHistory.contains(tripA) == false)
        
        
    }
   


}
