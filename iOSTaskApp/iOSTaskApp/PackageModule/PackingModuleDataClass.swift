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
    var name: String
    var earliestTripName: String
    var inDays: Int
    var colorName: String
    var percentage:Int {
      return trips.first?.percentage ?? 0
    }
    @Relationship(deleteRule: .cascade) var trips  = [Trip]()
    init(name: String = "Packing", earliestTripName: String, inDays: Int, colorName: String) {
        self.name = name
        self.earliestTripName = earliestTripName
        self.inDays = inDays
        self.colorName = colorName
    }
    var color:Color {
        switch colorName {
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        default: return .red
        }
    }
    
   
}


struct PackingMockData{
    static let packingMock = PackingModuleDataClass(name: "Packing",earliestTripName: "Trip 1", inDays: 10, colorName: "orange" )
    
    
    
    static let packingArr = [packingMock]
}


