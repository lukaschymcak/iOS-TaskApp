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
    @EnvironmentObject var plantsVM: PlantsModuleViewModel


    

    var body: some View {
     
            
            if let singleModule = singleModule{
                ZStack(alignment: .trailing) {
                    NavigationLink {
                        PlantsModuleOpen()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(plantsVM)
                    } label: {
                        PlantsModuleCell()
                            .environmentObject(plantsVM)
                        
                    }.onAppear(perform: {
                        plantsVM.setSelectedModule(a: singleModule)
                        
                        
                    })

                    .frame(maxWidth: .infinity)
            
                    
                
                }
            } else {
                VStack{
                    
                }
            }
        
            
        
    }

    
  
}


#Preview {
    PlantsModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
