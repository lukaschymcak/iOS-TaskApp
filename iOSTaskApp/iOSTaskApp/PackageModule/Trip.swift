//
//  Trip.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import Foundation
import SwiftData

@Model
class Trip{
    var id = UUID()
    var module: PackingModuleDataClass?
    var name: String
    var dateFrom: Date
    var dateTo: Date
    @Relationship(deleteRule: .cascade)
    var bags = [Bags]()

    init(id: UUID = UUID(), name: String, dateFrom: Date, dateTo: Date , module: PackingModuleDataClass? = nil) {
        self.id = id
        self.name = name
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.module = module
       
    }
    
    func dayDifference() -> Int{
        return Calendar.current.dateComponents([.day], from: Date.now, to: dateTo).day!
    }
    
   
}

struct MockData {
    static let tripData = Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now)
    
    static let tripsMocked = [tripData,tripData,tripData]
                              }
