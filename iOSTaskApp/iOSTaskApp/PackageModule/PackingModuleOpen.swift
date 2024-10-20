//
//  PackingModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct PackingModuleOpen: View {
    @State var name: String = "Packing"
    @State var color: Color = .orange
    @State var isAddModuleOpen: Bool = false
    @State var addingTrip: Bool = false
    
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack{
                
      
                CustomNavBarModule(module:"Packing",name:name)
                  
                    
                    
                    


                VStack(alignment:.center){
             
                        color.frame(width: 350, height: 5)
                            .clipShape(.rect(cornerRadius: 20))
                    
                    ListTripView(color: color,addingTrip: $addingTrip)
                   
                       
                    
                 
            
                }
                Spacer()
            }
            .padding(3)
        }
        .sheet(isPresented: $addingTrip) {
            AddingTripsSheetView()
        }
     
    }
}




#Preview {
    PackingModuleOpen()
        .modelContainer(for:Trip.self)
}
