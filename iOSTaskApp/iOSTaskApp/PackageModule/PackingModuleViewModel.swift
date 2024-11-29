//
//  PackingModuleViewModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 29/11/2024.
//

import Foundation
import SwiftData
class PackingModuleViewModel:ObservableObject {
    
    @Published var selectedModule: PackingModuleDataClass
    @Published var selectedTrip: Trip?
    @Published var toast: Toast?
    
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

