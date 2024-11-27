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
    @Environment(\.modelContext) var context
    @Query var plantsModule:[PlantsModuleDataClass]
    var singleModule: PlantsModuleDataClass? { plantsModule.first }
    @StateObject var plantsModuleModel: ViewModel = ViewModel()

    var body: some View {
   
            
            
            if let singleModule = singleModule{
                NavigationLink {
                    PlantsModuleOpen()
                        .navigationTransition(.zoom(sourceID: "pot", in: namespace))
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(plantsModuleModel)
                } label: {
                    PlantsModuleCell()
                        .environmentObject(plantsModuleModel)
                        .onAppear {
                            
                            if Utils.check(){
                                plantsModuleModel.selectedModule.refreshPlants(a: singleModule)
                                plantsModuleModel.selectedModule.waterPlants()
                                
                            }
                            
                        }
                }.onAppear(perform: {
                    plantsModuleModel.setSelectedModule(a: singleModule)
                    
                })
                .padding(.horizontal)
                .padding(.vertical,5)
            }
            
        
    }
    
  
}

#Preview {
    PlantsModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
