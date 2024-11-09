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


    var body: some View {
        if let onlyModule = packinModule {
            NavigationLink {
                PackingModuleOpen(module: onlyModule)
                    .navigationTransition(.zoom(sourceID: "world", in: namespace))
                    .navigationBarBackButtonHidden(true)
         
            } label: {
                PackingModule(packingModule: onlyModule)
            
            }
            .padding(.horizontal)
            .padding(.vertical,5)
        }
        
        
        }
        
        
        
        
        

        
            
        
    }



#Preview {
    PackageModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}
