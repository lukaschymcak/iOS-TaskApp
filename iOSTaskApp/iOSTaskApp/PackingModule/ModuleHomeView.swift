//
//  ModuleHomeView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 20/10/2024.
//

import SwiftUI
import SwiftData

struct PackageModuleHomeView: View {
    @Namespace private var namespace
    @Environment(\.modelContext) var context
    @Query var packingModule :[PackingModuleDataClass]
    var packinModule: PackingModuleDataClass? { packingModule.first }
    @EnvironmentObject var packingVM: PackingModuleViewModel
    @EnvironmentObject var dateManager: DateManager
    @State private var cardOffset = CGSize.zero
    @State private var showDeleteAlert:Bool = false

    
    
    
    var body: some View {
        if let onlyModule = packinModule {
            ZStack(alignment: .trailing){
                    HStack(spacing: 0){
                        
                        NavigationLink {
                            PackingModuleOpen(module: onlyModule)
                                .navigationBarBackButtonHidden(true)
                            
                            
                        } label: {
                            PackingModule(packingModule: onlyModule)
                                .environmentObject(dateManager)
                            
                            
                            
                            
                            
                            
                        }
                        
                        .onAppear {
                            packingVM.setSelectedModule(a: onlyModule)
                            
                            
                            
                        }.frame(maxWidth: .infinity,alignment: .leading)
                        
                        
                        
                    }
            
                

            }
            
            
            
        }
        VStack{
            
        }
        
        
        
        
        
        
        
        
        
        
    }
}


#Preview {
    PackageModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
