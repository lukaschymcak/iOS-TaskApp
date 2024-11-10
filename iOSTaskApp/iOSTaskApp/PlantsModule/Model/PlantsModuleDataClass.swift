//
//  PlantsModuleDataClass.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/10/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PlantsModuleDataClass:Identifiable {
    func amIaModule() -> Bool {
        return true
    }
    
    @Attribute(.unique) var Id: UUID = UUID()
    private(set) var name: String = "Plants"
    @Relationship(deleteRule: .cascade)
     var plants: [PlantModel]

    init( plants: [PlantModel] = []) {
    
        self.plants = plants
    }
    var wateredLocations: [houseLocation : [PlantModel]] {
        Dictionary(grouping: plants, by: {$0.location})
    }
    var preparedLocations:[PlantModel] {
        plants.filter { plant in
            plant.prepared
        }
    }

    var needWatering: Int {
        var counter: Int = 0
        for plant in plants {
            if !plant.prepared && plant.waterDate.isToday() {
                counter += 1
            }
        }
        return counter
    }
    func getName() -> String {
        return name
    }

}

struct MockPlantsModule {
    static let moduleA = PlantsModuleDataClass()
}

enum houseLocation: String, Codable, CaseIterable, Identifiable {
    case kitchen = "Kitchen"
    case livingRoom = "Living Room"
    case bedroom = "Bedroom"
    case bathroom = "Bathroom"
    case diningRoom = "Dining Room"
    case kidsRoom = "Kids Room"
    case all = "All"

    var id: String { self.rawValue }

}
enum waterTime: String, Codable,Identifiable {
    case today,tomorrow,thisWeek,afterWeek
    
    var id: Int {self.hashValue}
}
