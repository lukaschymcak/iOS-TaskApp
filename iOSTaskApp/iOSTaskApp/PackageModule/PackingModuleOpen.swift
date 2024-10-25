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
                        
                        NavigationLink {
                            if module.tripHistory.isEmpty{
                                Text("No History yet")
                            }
                            ForEach(module.tripHistory){ history in
                                TripCell(historyView: true, trip: history, color: module.color, module: module)}
                        } label: {
                            Text("History")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(Utils.textColor(colorScheme))
                            
                            
                        }
                        
                        
                    } .padding(.top,10)
                        .frame(width: GeometryProxy.size.width - 30)
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
}




#Preview {
    PackingModuleOpen(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
}
