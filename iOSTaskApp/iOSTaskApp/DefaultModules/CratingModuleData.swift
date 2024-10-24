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
class CreatingModuleData {
    var id:UUID
    var name: String
    var colorName: String
    var desc: String = ""
   

    init(id:UUID = UUID(), name: String, colorName: String,desc:String = "") {
        self.id = id
        self.name = name
        self.colorName = colorName
        self.desc = desc
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
    static let packing = CreatingModuleData(name: "Packing", colorName: "orange",desc: "Effortlessly organize your trips with our packing module – create trips, track items, and never forget essentials!" )
    static let pills = CreatingModuleData(name: "Pills", colorName: "yellow",desc: "")
    static let gymTracker = CreatingModuleData(name: "Gym Tracker", colorName: "green",desc: "")
    
    static var defaults: [CreatingModuleData] = [packing, pills, gymTracker].sorted(by: {$0.name < $1.name})
    
    
}

    


