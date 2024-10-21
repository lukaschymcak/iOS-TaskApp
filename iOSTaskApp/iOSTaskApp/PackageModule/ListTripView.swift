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
    @Query(sort:\Trip.dateFrom,order: .reverse) var trips: [Trip]

    var body: some View {
        GeometryReader{ GeometryProxy in
            if trips.isEmpty{
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
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    Text("No trips yet")
                        .frame(maxWidth: .infinity)
                }
           
                Spacer()
            }else {
                NavigationStack{
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
                        }
                        
                    }
                    ScrollView{
                        ForEach(trips,id: \.id) { trip in
                            NavigationLink {
                                BagsView()
                                    .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                TripCell(trip: trip,color: color)
                            }
                            
                            
                            
                        }
                    }
                    
                }
            }
        }
    }
}
#Preview {
    ListTripView(color: .red,addingTrip: .constant(false) )
      
}
