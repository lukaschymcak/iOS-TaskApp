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
    @StateObject var vmParent = ViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack{
                GeometryReader { GeometryProxy in
                    Color(hex: "22577A")
                        .ignoresSafeArea()
                    VStack{
                        
                        
                        HStack {
                            CustomNavBarModule(module:"Packing",name:module.name == "" ? "Packing" : module.name)
        
                        } .padding(.top,10)
                            .frame(width: GeometryProxy.size.width - 30)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.orange,lineWidth: 5)
                                .fill(.clear)
                                .frame(width: 120, height: 50)
                                .offset(x: vmParent.openingHistory ? 135 : 15)
                                .animation(.spring, value: vmParent.openingHistory)
                                .zIndex(2)
                            
                            
                            
                            ZStack(alignment: .leading) {
                             
                                    
                                HStack(spacing: 25){
                                    Button {
                                
                                            vmParent.openingHistory = false
                                     
                                        
                                        
                                        
                                        
                                    } label: {
                                        Text("Current")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color(hex: "22577A"))
                                    }
                                    
                                    Button {
                                        
                                            vmParent.openingHistory = true
                                 
                                        
                                        
                                        
                                    } label: {
                                        Text("History")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color(hex: "22577A"))
                                    }
                                    Spacer()
                                    
                                }
                                .padding(.leading,24)
                                .zIndex(2)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(hex: "FEFAE0"))
                                    .frame(width: GeometryProxy.size.width - 130, height: 65)
                            }
                            
                        } .frame(width: GeometryProxy.size.width - 40)
                        
                        Color.orange.frame(width: GeometryProxy.size.width - 30, height: 5)
                            .clipShape(.rect(cornerRadius: 20))
                            .offset(y: -5)
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "FEFAE0"))
                                .frame(width: GeometryProxy.size.width - 20, height: GeometryProxy.size.height - 180)
                    
                            VStack(alignment:.center){
                               
                                ListTripView(module: module)
                                    .environmentObject(vmParent)
                                    .zIndex(3)
                                
                                
                                
                                
                                
                            }.frame(width: GeometryProxy.size.width - 20, height: GeometryProxy.size.height - 180)
                                .frame(maxWidth: .infinity,alignment: .center)
                        }
                        Spacer()
                    }
                    
                }
                .sheet(isPresented: $vmParent.addingTrip) {
                    AddingTripsSheetView(module: module)
                }
                
            }
        }
    }
}

extension PackingModuleOpen {
    class ViewModel:ObservableObject {
        @Published var isAddModuleOpen: Bool = false
        @Published var addingTrip: Bool = false
        @Published var openingHistory : Bool = false
        
        func toggleAddingTrip(){
            addingTrip.toggle()
        }
        func toggleAddingModule(){
            isAddModuleOpen.toggle()
        }
        func openHistory(){
            openingHistory.toggle()
        }
        
    }
}



#Preview {
    PackingModuleOpen(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
}
