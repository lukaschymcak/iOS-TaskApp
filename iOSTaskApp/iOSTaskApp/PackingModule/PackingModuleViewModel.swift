//
//  PackingModuleViewModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 29/11/2024.
//

import Foundation
import SwiftData
class PackingModuleViewModel:ObservableObject {
    
    @Published var selectedModule: PackingModuleDataClass?
    @Published var selectedTrip: Trip?
    @Published var toast: Toast?
    
    var isReadyForNotification: Bool {
        if let module = selectedModule {
            return module.dayDifference <= 3
        }
        return false
    }
    
    func checkAndAddToHistory() {
        if let module = selectedModule {
            if let earliestTrip = module.earliestTrip {
                if earliestTrip.dateFrom < Date() {
                    module.addTripHistory(a:earliestTrip)
                    module.removeTrip(a: earliestTrip)
                }
            }
            
        }
    }
    
    init(selelectedModule:PackingModuleDataClass = PackingModuleDataClass()) {
        
        self.selectedModule = selelectedModule
    }

        
    func setSelectedModule(a:PackingModuleDataClass){
        selectedModule = a
    }
    
    func createModule(context: ModelContext){
        let module = PackingModuleDataClass()
        context.insert(module)
    }
        
        
    }

