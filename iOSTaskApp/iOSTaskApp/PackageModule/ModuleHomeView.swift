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
    @Query var packingModule :[PackingModuleDataClass]
    var packinModule: PackingModuleDataClass? { packingModule.first }
    @EnvironmentObject var packingVM: PackingModuleViewModel
    @EnvironmentObject var dateManager: DateManager
    
    
    var body: some View {
        if let onlyModule = packinModule {
            NavigationLink {
                PackingModuleOpen(module: onlyModule)
                    .navigationBarBackButtonHidden(true)
                
                
            } label: {
                PackingModule(packingModule: onlyModule)
                    .environmentObject(dateManager)
    
                
                
                
            }
            .padding(.horizontal)
            .padding(.vertical,5)
            .onAppear {
                packingVM.setSelectedModule(a: onlyModule)
                
                
                }
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
}


#Preview {
    PackageModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
