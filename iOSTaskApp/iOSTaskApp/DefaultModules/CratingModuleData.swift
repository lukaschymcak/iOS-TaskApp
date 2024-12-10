//
//  PackingModuleData.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 16/10/2024.
//

import Foundation
import SwiftUI
import SwiftData

class CreatingModuleData {
    var id:UUID
    var name: String
    var colorName: String
    var secondaryColorName: String
    var desc: String = ""
   

    init(id:UUID = UUID(), name: String, colorName: String,secondaryColorName: String,desc:String = "") {
        self.id = id
        self.name = name
        self.secondaryColorName = secondaryColorName
        self.colorName = colorName
        self.desc = desc
    }
    
    var color:Color {
        switch colorName {
        case "blue": return Color(hex: "22577A")
        case "orange": return .orange
        case "creamyWhite" : return Color(hex: "FEFAE0")
 
        default: return .red
        }
    }
    var secondaryColor:Color {
        switch secondaryColorName {
        case "orange" : return .orange
        case "green": return Color(hex: "606C38")
            default: return .green
        }
    }
    


   
}

struct DefaultModules {
    static let packing = CreatingModuleData(name: "Packing", colorName: "blue",secondaryColorName: "orange", desc: "Effortlessly organize your trips with our packing module – create trips, track items, and never forget essentials!" )
    static let plants = CreatingModuleData(name: "Plants", colorName: "creamyWhite",secondaryColorName: "green", desc: "Simple, reliable watering reminders to keep your plants healthy and thriving")
    
    static var defaults: [CreatingModuleData] = [packing, plants].sorted(by: {$0.name < $1.name})
    
    
}

    


