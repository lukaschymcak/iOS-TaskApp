//
//  PlantsModuleHomeView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI
import SwiftData

struct PlantsModuleHomeView: View {
    @Namespace private var namespace
    @Query var plantsModule:[PlantsModuleDataClass]
    var body: some View {
        ForEach(plantsModule){ module in
            NavigationLink {
                PlantsModuleOpen(plantsModule: module)
                    .navigationTransition(.zoom(sourceID: "pot", in: namespace))
                    .navigationBarBackButtonHidden(true)
            } label: {
               
                    PlantsModuleCell(plantsModule: module)
                    .onAppear {
                        if check(){
                            refreshPlants(a: module)
                            module.waterPlants()
                            
                        }
                        
                    }
                   
                    
                       
                 
                }
            .padding(.horizontal)
            .padding(.vertical,5)
                    
        }
    }
    func refreshPlants(a:PlantsModuleDataClass){
        for plants in a.plants {
    
                if plants.watered {
                    plants.toggleNotWatered()
                }
            }
        
    }
    
    func check() -> Bool {
            if let referenceDate = UserDefaults.standard.object(forKey: "reference") as? Date {
                if !Calendar.current.isDateInToday(referenceDate) {
                    UserDefaults.standard.set(Date(), forKey: "reference")
                    return true
                }
            } else {
             
                UserDefaults.standard.set(Date(), forKey: "reference")
                return true
            }
            return false
        }
}

#Preview {
    PlantsModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
