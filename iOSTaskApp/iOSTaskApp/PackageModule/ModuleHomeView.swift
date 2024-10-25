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
                VStack(alignment: .leading){
                   
                        PackingModule(packingModule: module)
                        
                    }.onAppear {
                        
                        if let packingModule = packingModule.first {
                            if packingModule.trips.first != nil {
                                packingModule.trips.sort(by: {$0.dateTo < $1.dateTo})
                            }
                        }
                    }
                    
                       
                 
                }
                .padding()
                    
        }
        
        }
        
        
        
        
        

        
            
        
    }

#Preview {
    PackageModuleHomeView()
        .modelContainer(for: PackingModuleDataClass.self)
}