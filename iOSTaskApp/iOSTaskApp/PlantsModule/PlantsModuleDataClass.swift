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
class PlantsModuleDataClass {
    private(set) var name: String
    private(set) var colorName: String
    @Relationship(deleteRule: .cascade)
    private(set) var plants: [PlantModel]

    init(name: String, colorName: String, plants: [PlantModel] = []) {
        self.name = name
        self.colorName = colorName
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

    var color: Color {
        switch colorName {
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        default: return .red
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


    
  

    func getAllLocations() -> [houseLocation] {
        var caseArray: [houseLocation] = []
        for loc in houseLocation.allCases {
            caseArray.append(loc)
        }
        return caseArray
    }

    func setName(a: String) {
        self.name = a
    }
    func setColor(a: String) {
        self.colorName = a
    }
    func addPlants(a: PlantModel) {
        self.plants.append(a)
    }
    func removePlants(a: PlantModel) {
        if let index = self.plants.firstIndex(of: a) {
            self.plants.remove(at: index)
        }
    }
    func filterByLocation(a: houseLocation) -> [PlantModel] {
        return plants.filter { plant in
            plant.location == a
        }
    }
    func getTodayPlants(location:houseLocation) -> [PlantModel] {
        let today = Date.now
        return plants.filter { plant in
            Calendar.current.isDateInToday(plant.waterDate) && plant.location == location
        }
    }
    func getTmrwPlants(location:houseLocation) -> [PlantModel] {
        return plants.filter { plant in
            Calendar.current.isDateInTomorrow(plant.waterDate) && plant.location == location
        }
    }

    func getWeekPlants(location:houseLocation) -> [PlantModel]? {
        let tmrw = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)
        if let tmrw = tmrw {
            let nextWeek = Calendar.current.date(
                byAdding: .day, value: 6, to: tmrw)
            if let nextWeek = nextWeek {
                return plants.filter { plant in
                    plant.waterDate > tmrw && plant.waterDate < nextWeek && plant.location == location
                }
            }
        }
        return nil
    }
    
        func getRestPlants(location:houseLocation) -> [PlantModel]? {
            let morethanWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date.now)
            if let morethanWeek = morethanWeek {
                return plants.filter { plant in
                    plant.waterDate >= morethanWeek
                }
            }
            return nil
        }
     
    
    func getForgottenPlants(location:houseLocation) -> [PlantModel]{
        return plants.filter { plant in
            plant.waterDate.isBeforeToday() && plant.location == location
        }.sorted { $0.waterDate < $1.waterDate}
        }
    
    func getAllPlants() -> [PlantModel] {
        return plants.sorted { $0.waterDate < $1.waterDate }
    }
    func waterPlants() {
        plants.filter { plant in
            plant.prepared
        }.forEach { plant in
            if let dateIncrease = Calendar.current.date(
                byAdding: .day, value: plant.frequency,
                to: plant.waterDate) {
                plant.toggleWatered()
                plant.setWaterDate(a: dateIncrease)
                plant.unPrepare()
                
            }
        }
        
    }
}

struct MockPlantsModule {
    static let moduleA = PlantsModuleDataClass(
        name: "Plant", colorName: "red")
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
