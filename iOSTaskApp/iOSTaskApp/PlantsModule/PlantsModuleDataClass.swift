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
            if !plant.watered {
                counter += 1
            }
        }
        return counter
    }

    var wateringLocations: [houseLocation: Int] {
        var counts: [houseLocation: Int] = [:]
        for plant in plants {
            if !plant.watered {
                counts[plant.location, default: 0] += 1
            } else {
                counts[plant.location, default: 0] += 0
            }
        }
        return counts

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
    func getTodayPlants() -> [PlantModel] {
        let today = Date.now
        return plants.filter { plant in
            Calendar.current.isDate(today, inSameDayAs: plant.waterDate)
        }
    }

    func getWeekPlants() -> [PlantModel]? {
        let today = Date.now
        let nextWeek = Calendar.current.date(
            byAdding: .day, value: 5, to: today)
        if let nextWeek = nextWeek {
            return plants.filter { plant in
                plant.waterDate > today && plant.waterDate < nextWeek
            }
        }
        return nil
    }
    func getRestPlants() -> [PlantModel]? {
        let today = Date.now
        let nextWeek = Calendar.current.date(
            byAdding: .day, value: 5, to: today)
        if let nextWeek = nextWeek {
            return plants.filter { plant in
                plant.waterDate > nextWeek
            }
        }
        return nil
    }
}

struct MockPlantsModule {
    static let moduleA = PlantsModuleDataClass(
        name: "Plant", colorName: "red", plants: MockPlants.mockedPlants)
}

enum houseLocation: String, Codable, CaseIterable, Identifiable {
    case kitchen = "Kitchen"
    case livingRoom = "Living Room"
    case bedroom = "Bedroom"
    case bathroom = "Bathroom"
    case diningRoom = "Dining Room"
    case kidsRoom = "Kids Room"

    var id: String { self.rawValue }

}
