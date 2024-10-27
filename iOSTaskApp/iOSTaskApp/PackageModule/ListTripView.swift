//
//  ListTripView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import SwiftUI
import SwiftData
struct ListTripView: View {
    var color: Color
    @Namespace private var namespace
    @Binding var addingTrip: Bool
    @State var module:PackingModuleDataClass
    @Binding var showHistory:Bool
    var body: some View {
        GeometryReader{ GeometryProxy in
            
            VStack {
                HStack {
                    Text("\(showHistory ? "TRIP HISTORY:" : "MY TRIPS:")")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                
                    Spacer()
                    if showHistory {
                        
                    } else {
                        Button {
                            addingTrip.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(color)
                        }
                    }
                    
                }.frame(width: GeometryProxy.size.width - 30,alignment: .leading)
                .frame(maxWidth: .infinity)
            
                    NavigationStack{
                        
                        ScrollView{
                            
                            if showHistory {
                                if module.tripHistory  == []{
                                    Text("No trips yet")
                                        .frame(maxWidth: .infinity)
                                } else {
                                    ForEach(module.tripHistory.sorted(by: {$0.dateTo < $1.dateTo}),id: \.id) { trip in
                                        
                                        NavigationLink {
                                            BagsView(trip: trip, color: color, historyView: $showHistory)
                                                .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            TripCell(historyView: $showHistory, trip: trip,color: color,module:module)
                                                .animation(.linear, value: showHistory)
                                                .transition(.move(edge: .trailing))
                                              
                                             
                                                 
                                        }
                                        .animation(.linear, value: showHistory)
                                        .transition(.move(edge: .trailing))
                                        
                           
                                    }
                                    
                                }
                                
                            }else {
                                if module.trips  == []{
                                    Text("No trips yet")
                                        .frame(maxWidth: .infinity)
                                } else {
                                    ForEach(module.trips.sorted(by: {$0.dateTo < $1.dateTo}),id: \.id) { trip in
                                        
                                        NavigationLink {
                                            BagsView(trip: trip, color: color, historyView: $showHistory)
                                                .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            TripCell(historyView: $showHistory, trip: trip,color: color,module:module)
                                                .animation(.linear, value: showHistory)
                                                .transition(.move(edge: .leading))
                                               
                                            
                                        }
                                        .animation(.linear, value: showHistory)
                                        .transition(.move(edge: .leading))
                                        
                                 
                                   
                                        
                                        
                                    }
                                }
                            }
                            
                        }
                        
                      
                    }
                    
                    
                    
                
            }
        }
    }
}
#Preview {
    ListTripView(color: .red,addingTrip: .constant(false) ,module: PackingMockData.packingMock, showHistory: .constant(true))
      
}
