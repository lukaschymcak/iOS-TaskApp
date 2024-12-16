//
//  PlantsModuleHomeViewModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 08/11/2024.
//

import Foundation
import SwiftData

class PlantsModuleViewModel:ObservableObject {
        
        @Published var selectedModule:PlantsModuleDataClass
        @Published var selectedPlants: PlantModel?
        @Published var toast: Toast?
        
        init(selelectedModule:PlantsModuleDataClass = PlantsModuleDataClass()) {
            
            self.selectedModule = selelectedModule
        }
 
      
    var filteredPlants: [(key:houseLocation,value:[PlantModel])] {
      
        return selectedModule.wateredLocations.filter({$0.value.filter({$0.watered == false && $0.waterDate.isToday() || $0.waterDate.isBeforeToday()}).count > 0})
        
    }
          
            
        
        func setSelectedModule(a:PlantsModuleDataClass){
            selectedModule = a
        }
        
        func createModule(context: ModelContext){
            let module = PlantsModuleDataClass()
            context.insert(module)
        }
            
            
        }
    

