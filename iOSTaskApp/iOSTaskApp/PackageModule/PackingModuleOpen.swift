//
//  PackingModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct PackingModuleOpen: View {
    @Environment(\.colorScheme) var colorScheme
    var module:PackingModuleDataClass
    @State var isAddModuleOpen: Bool = false
    @State var addingTrip: Bool = false
    @State var openingHistory : Bool = false
    
    var body: some View {
        NavigationStack{
            GeometryReader { GeometryProxy in
                VStack{
                    
                    
                    HStack {
                        CustomNavBarModule(module:"Packing",name:module.name == "" ? "Packing" : module.name)
                        
                        
                        
                        
                        
                        
                        
                    } .padding(.top,10)
                        .frame(width: GeometryProxy.size.width - 30)
                       
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(module.color,lineWidth: 7)
                            .fill(.clear)
                            .frame(width: 120, height: 50)
                            .offset(x: openingHistory ? 122 : 0)
                            .animation(.spring, value: openingHistory)
                         
                        
                        
                        HStack(spacing: 25){
                            Button {
                                withAnimation {
                                    openingHistory = false
                                }
                                  
                                
               
                                
                            } label: {
                                Text("Current")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Utils.textColor(colorScheme))
                            }
                         
                            Button {
                                withAnimation {
                                    openingHistory = true
                                }
                               
                                
                          
                            } label: {
                                Text("History")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Utils.textColor(colorScheme))
                            }
                            Spacer()
                            
                        }.padding(.leading,10)
                    } .frame(width: GeometryProxy.size.width - 40)
                    
                    module.color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                    VStack(alignment:.center){
                        
                        ListTripView(color: module.color,addingTrip: $addingTrip,module:module, showHistory: $openingHistory)
                           
                        
                        
                        
                        
                        
                    }
                    Spacer()
                }
                
            }
            .sheet(isPresented: $addingTrip) {
                AddingTripsSheetView(module: module)
            }
            
        }
    }
}





#Preview {
    PackingModuleOpen(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
}
