//
//  ListTripView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import SwiftUI
import SwiftData
struct ListTripView: View {
    @State var color: Color = .orange
    @Binding var addingTrip: Bool
    @Query var trips: [Trip]
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
                                Text(trip.name)
                            } label: {
                                TripCell(trip: trip)
                            }
                            
                            
                            
                        }.padding(.vertical)
                    }
                    
                }
            }
        }
    }
}
#Preview {
    ListTripView(addingTrip: .constant(false))
      
}
