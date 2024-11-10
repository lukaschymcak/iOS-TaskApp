//
//  PlantsModuleHomeViewModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 08/11/2024.
//

import Foundation
import SwiftData

extension PlantsModuleHomeView {
    class ViewModel:ObservableObject {
        
        @Published var selectedModule:PlantsModuleDataClass
        @Published var selectedPlants: PlantModel?
        @Published var toast: Toast?
        
        init(selelectedModule:PlantsModuleDataClass = PlantsModuleDataClass()) {
            
            self.selectedModule = selelectedModule
        }
 
            
        
        func setSelectedModule(a:PlantsModuleDataClass){
            selectedModule = a
        }
        
        func addPlant(a:PlantModel){
            selectedModule.plants.append(a)
        }
        func removePlant(a:PlantModel){
            
            if let index = selectedModule.plants.firstIndex(of: a) {
                self.selectedModule.plants.remove(at: index)
            }
        }
    
    
        private func getTodayPlants(location:houseLocation) -> [PlantModel] {
            let today = Date.now
            return selectedModule.plants.filter { plant in
                Calendar.current.isDateInToday(plant.waterDate) && plant.location == location
            }
        }
        private func getTmrwPlants(location:houseLocation) -> [PlantModel] {
            return selectedModule.plants.filter { plant in
                Calendar.current.isDateInTomorrow(plant.waterDate) && plant.location == location
            }
        }
        
        private  func getWeekPlants(location:houseLocation) -> [PlantModel] {
            let tmrw = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)
            if let tmrw = tmrw {
                let nextWeek = Calendar.current.date(
                    byAdding: .day, value: 6, to: tmrw)
                if let nextWeek = nextWeek {
                    return selectedModule.plants.filter { plant in
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
                return selectedModule.plants.filter { plant in
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
                return selectedModule.plants.filter { plant in
                    plant.waterDate.isBeforeToday() && plant.location == location
                }.sorted { $0.waterDate < $1.waterDate}
            }
            
            func getAllPlants() -> [PlantModel] {
                return selectedModule.plants.sorted { $0.waterDate < $1.waterDate }
            }
            func waterPlants() {
                selectedModule.plants.filter { plant in
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
                    
                    if plants.watered {
                        plants.toggleNotWatered()
                    }
                }
                
            }
            
            
        }
    }

