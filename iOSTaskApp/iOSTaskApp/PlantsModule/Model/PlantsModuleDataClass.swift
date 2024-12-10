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
            if !plant.watered && (plant.waterDate.isToday() || plant.waterDate.isBeforeToday()) {
                counter += 1
            }
        }
        return counter
    }
    func getName() -> String {
        return name
    }
    func addPlant(a:PlantModel){
        
        plants.append(a)
    }
    func removePlant(a:PlantModel){
        
        if let index = plants.firstIndex(of: a) {
        plants.remove(at: index)
        }
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
    case today = "Today"
    case tomorrow = "Tomorrow"
    case thisWeek = "This Week"
    case afterWeek = "More than a week"
    
    var id: Int {self.hashValue}
}

extension PlantsModuleDataClass {
    private func getTodayPlants(location:houseLocation) -> [PlantModel] {
        return plants.filter { plant in
            Calendar.current.isDateInToday(plant.waterDate) && plant.location == location
        }
    }
    private func getTmrwPlants(location:houseLocation) -> [PlantModel] {
        return plants.filter { plant in
            Calendar.current.isDateInTomorrow(plant.waterDate) && plant.location == location
        }
    }
    
    private  func getWeekPlants(location:houseLocation) -> [PlantModel] {
        let tmrw = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)
        if let tmrw = tmrw {
            let nextWeek = Calendar.current.date(
                byAdding: .day, value: 6, to: tmrw)
            if let nextWeek = nextWeek {
                return plants.filter { plant in
                    plant.waterDate > tmrw && plant.waterDate < nextWeek && plant.location == location
                }
            } else{
                return []
            }
        }
        return []
    }
    
    private func getRestPlants(location:houseLocation) -> [PlantModel] {
        let morethanWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date.now)
        if let morethanWeek = morethanWeek {
            return plants.filter { plant in
                plant.waterDate >= morethanWeek && plant.location == location
            }
        }
        return []
    }
        
    
   

        
        func filterByDateAndLocation(when time: waterTime, location:houseLocation) -> [PlantModel] {
            switch time {
            case .today:
             return   getTodayPlants(location: location)
            case .tomorrow:
                return    getTmrwPlants(location: location)
            case .thisWeek:
                return   getWeekPlants(location: location)
            case .afterWeek:
                return   getRestPlants(location: location)
                
                
            }
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
        func refreshPlants(a:PlantsModuleDataClass){
            for plants in a.plants {
                
                if plants.watered  && plants.waterDate.isToday() || plants.waterDate.isBeforeToday() {
                    plants.toggleNotWatered()
                }
            }
            
        }
}
