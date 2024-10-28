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
                    .navigationTransition(.zoom(sourceID: "world", in: namespace))
                    .navigationBarBackButtonHidden(true)
            } label: {
               
                    PlantsModuleCell(plantsModule: module)
                        
                   
                    
                       
                 
                }
            .padding(.horizontal)
            .padding(.vertical,5)
                    
        }
    }
}

#Preview {
    PlantsModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
