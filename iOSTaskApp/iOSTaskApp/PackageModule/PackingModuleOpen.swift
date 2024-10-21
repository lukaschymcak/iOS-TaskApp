//
//  PackingModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct PackingModuleOpen: View {
           var name: String
           var color: Color
    @State var isAddModuleOpen: Bool = false
    @State var addingTrip: Bool = false
    
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack{
                
      
                CustomNavBarModule(module:"Packing",name:name == "" ? "Packing" : name)
                    .padding(.top,30)
                    .frame(width: GeometryProxy.size.width - 30,height: 25)
                color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                VStack(alignment:.center){
             
                    
                    
                   ListTripView(color: color,addingTrip: $addingTrip)
                   
                       
                    
                 
            
                }
                Spacer()
            }
      
        }
        .sheet(isPresented: $addingTrip) {
            AddingTripsSheetView()
        }
     
    }
}




#Preview {
    PackingModuleOpen(name:"Test",color: .red)
        .modelContainer(for:Trip.self)
}
