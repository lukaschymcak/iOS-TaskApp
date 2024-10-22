//
//  PackingModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct PackingModuleOpen: View {
    var module:PackingModuleDataClass
    @State var isAddModuleOpen: Bool = false
    @State var addingTrip: Bool = false
    
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack{
                
      
                CustomNavBarModule(module:"Packing",name:module.name == "" ? "Packing" : module.name)
                    .padding(.top,30)
                    .frame(width: GeometryProxy.size.width - 30,height: 25)
                module.color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                VStack(alignment:.center){
             
                    
                    
                    ListTripView(color: module.color,addingTrip: $addingTrip,module:module)
                   
                       
                    
                 
            
                }
                Spacer()
            }
      
        }
        .sheet(isPresented: $addingTrip) {
            AddingTripsSheetView(module: module)
        }
     
    }
}




#Preview {
    PackingModuleOpen(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
}
