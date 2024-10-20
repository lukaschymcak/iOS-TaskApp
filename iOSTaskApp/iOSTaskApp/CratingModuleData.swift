//
//  PackingModuleData.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 16/10/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class CreatingModuleData:Identifiable {
    var id:String
    var name: String
    var colorName: String

    
    init(name: String, colorName: String) {
        self.name = name
        self.colorName = colorName
        self.id = UUID().uuidString
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

struct DefaultModules {
    static let packing = CreatingModuleData(name: "Packing", colorName: "orange")
    static let pills = CreatingModuleData(name: "Pills", colorName: "yellow")
    static let gymTracker = CreatingModuleData(name: "Gym Tracker", colorName: "green")
    
    static let defaults: [CreatingModuleData] = [packing, pills, gymTracker]
}


