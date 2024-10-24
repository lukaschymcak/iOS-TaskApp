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
    var body: some View {
        GeometryReader{ GeometryProxy in
            
            VStack {
                HStack {
                    Text("MY TRIPS:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: GeometryProxy.size.width - 80,alignment: .leading)
                    Button {
                        addingTrip.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                if module.trips == []{
                    Text("No trips yet")
                        .frame(maxWidth: .infinity)
                } else {
                    NavigationStack{
                        
                        ScrollView{
                            ForEach(module.trips.sorted(by: {$0.dateTo < $1.dateTo}),id: \.id) { trip in
                                
                                NavigationLink {
                                    BagsView(trip: trip, color: color)
                                        .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    TripCell(trip: trip,color: color,module:module)
                                }
                                
                                
                                
                                
                                
                            }
                            
                        }
                        
                        Spacer()
                    }
                    
                    
                    
                }
            }
        }
    }
}
#Preview {
    ListTripView(color: .red,addingTrip: .constant(false) ,module: PackingMockData.packingMock)
      
}
