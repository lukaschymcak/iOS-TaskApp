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
    var colorName: String
    var percentage:Int {
      if let firstTrip = trips.first {
          return firstTrip.percentage
        }
        return 0
    }
    @Relationship(deleteRule: .cascade) var trips  = [Trip]()
    @Relationship(deleteRule: .cascade) var tripHistory  = [Trip]()
    init(name: String = "Packing", colorName: String) {
        self.name = name
      
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
    static let packingMock = PackingModuleDataClass(name: "Packing", colorName: "orange" )
    
    
    
    static let packingArr = [packingMock]
}


