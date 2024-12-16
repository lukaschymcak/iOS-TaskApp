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
    @State private var cardOffset = CGSize.zero
    @State private var showDeleteAlert:Bool = false
    @AppStorage("isPlantsModuleCreated") var isPlantsModuleCreated = false
    

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
                        
                            .dragToDelete(cardOffset: $cardOffset) {
                                isPlantsModuleCreated = false
                                context.delete(plantsVM.selectedModule)
                                
                            }
                    }.onAppear(perform: {
                        plantsVM.setSelectedModule(a: singleModule)
                        
                        
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
