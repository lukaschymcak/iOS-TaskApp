//
//  PlantsModuleDataClass.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/10/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class PlantsModuleDataClass{
    private(set) var name: String
    private(set)var colorName: String
    @Relationship(deleteRule: .cascade)
    private(set) var plants = [PlantModel]()
    
    init(name: String, colorName: String) {
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
    
    var needWatering:Int {
        var counter:Int = 0
        for plant in plants {
            if(!plant.watered){
                counter += 1
            }
        }
        return counter
    }
    
    var wateringLocations:[houseLocation:Int] {
        var counts :[houseLocation:Int] = [:]
        for plant in MockPlants.mockedPlants {
            counts[plant.location, default: 0] += 1
        }
        return counts
    }
    
    func setName(a:String){
        self.name = a
    }
    func setColor(a:String){
        self.colorName = a
    }
    func addPlants(a:PlantModel){
        self.plants.append(a)
    }
    func removePlants(a:PlantModel){
        if let index = self.plants.firstIndex(of: a){
            self.plants.remove(at: index)
        }
    }
    
}

struct MockPlantsModule {
    static let moduleA = PlantsModuleDataClass(name: "Plant", colorName: "red")
}

enum houseLocation:String ,Codable{
    case kitchen = "Kitchen"
    case livingRoom = "Living Room"
    case bedroom = "Bedroom"
    case bathroom = "Bathroom"
    case diningRoom = "Dining Room"
    
    var id: String { self.rawValue }
    
    
}
