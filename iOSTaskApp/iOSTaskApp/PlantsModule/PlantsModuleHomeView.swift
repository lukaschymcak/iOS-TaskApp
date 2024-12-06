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
    @State private var cardOffset = CGSize.zero
    @State private var showDeleteAlert:Bool = false
    @AppStorage("isPlantsModuleCreated") var isPlantsModuleCreated = false
    

    var body: some View {
   
            
            
            if let singleModule = singleModule{
                ZStack(alignment: .trailing) {
                    NavigationLink {
                        PlantsModuleOpen()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(plantsModuleModel)
                    } label: {
                        PlantsModuleCell()
                            .environmentObject(plantsModuleModel)
                           
                            .dragToDelete(cardOffset: $cardOffset) {
                                isPlantsModuleCreated = false
                                context.delete(plantsModuleModel.selectedModule)
                                context.insert(DefaultModules.plants)
                            }
                    }.onAppear(perform: {
                        plantsModuleModel.setSelectedModule(a: singleModule)
                        plantsModuleModel.selectedModule.refreshPlants(a: singleModule)
                        plantsModuleModel.selectedModule.waterPlants()
                        
                    })
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.red)
                        .deleteCardSlow(cardOffset: $cardOffset,customHeight: singleModule.plants.isEmpty ? 150 : 180)
                }
            }
        VStack{
            
        }.onAppear {
            if singleModule == nil {
                isPlantsModuleCreated = false
            }
        }
            
        
    }
    
  
}

#Preview {
    PlantsModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
