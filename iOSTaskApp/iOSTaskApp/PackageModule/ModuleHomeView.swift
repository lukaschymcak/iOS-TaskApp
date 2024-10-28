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

    var body: some View {
        
        ForEach(packingModule){ module in
            NavigationLink {
                PackingModuleOpen(module:module)
                    .navigationTransition(.zoom(sourceID: "world", in: namespace))
                    .navigationBarBackButtonHidden(true)
            } label: {
             
                   
                        PackingModule(packingModule: module)
                        
               
                    
                       
                 
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
