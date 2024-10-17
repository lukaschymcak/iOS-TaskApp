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
class CreatingPackingModuleData {
    var name: String
    var colorName: String
    var size: String
    
    init(name: String, colorName: String, size: String) {
        self.name = name
        self.colorName = colorName
        self.size = size
    }

    var color: Color {
        switch colorName {
        case "Red":
            return .red
        case "Blue":
            return .blue
        case "Yellow":
            return .yellow
        case "Green":
            return .green
        case "Orange":
            return .orange
        default:
            return .black
        }
    }
}
