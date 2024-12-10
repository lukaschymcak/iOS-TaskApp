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
 
      
            
          
            
        
        func setSelectedModule(a:PlantsModuleDataClass){
            selectedModule = a
        }
        
        func createModule(context: ModelContext){
            let module = PlantsModuleDataClass()
            context.insert(module)
        }
            
            
        }
    

