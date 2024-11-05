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
    @State private var toast: Toast? = nil
    var body: some View {
        GeometryReader{ GeometryProxy in
            
            VStack {
                HStack {
                    Text("\(showHistory ? "TRIP HISTORY:" : "MY TRIPS:")")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical,15)
                        .foregroundStyle(Color(hex: "22577A"))
                
                    Spacer()
                    if !showHistory {
                        Button {
                            addingTrip.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
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
                                        .foregroundStyle(Color(hex: "22577A"))
                                        .font(.title)
                                        .fontWeight(.bold)
                                } else {
                                    ForEach(module.tripHistory.sorted(by: {$0.dateTo < $1.dateTo}),id: \.id) { trip in
                                        
                                        NavigationLink {
                                            BagsView(trip: trip, color: color, historyView: $showHistory)
                                                .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            TripCell(historyView: $showHistory, trip: trip,color: color,module:module, toast: $toast)
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
                                        .foregroundStyle(Color(hex: "22577A"))
                                        .font(.title)
                                        .fontWeight(.bold)
                                } else {
                                    ForEach(module.trips.sorted(by: {$0.dateTo < $1.dateTo}),id: \.id) { trip in
                                        
                                        NavigationLink {
                                            BagsView(trip: trip, color: color, historyView: $showHistory)
                                                .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            TripCell(historyView: $showHistory, trip: trip,color: color,module:module, toast: $toast)
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
                    
                    
                    
                
            }.toastView(toast: $toast) {
                
            }
        }
    }
}
#Preview {
    ListTripView(color: .red,addingTrip: .constant(false) ,module: PackingMockData.packingMock, showHistory: .constant(false))
      
}
