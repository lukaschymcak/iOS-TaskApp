//
//  TripCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import SwiftUI

struct TripCell: View {
    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme
    @Binding var historyView: Bool
    let trip:Trip
    var color:Color
    @State var module:PackingModuleDataClass
    var body: some View {
        
        if historyView {
            tripHistory
        } else{
            
            tripCurrent
        }
        
            
    }
    @ViewBuilder
    var tripHistory: some View {
        GeometryReader { GeometryProxy in
            ZStack(alignment: .center) {
                
                VStack(alignment:.center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorScheme == .dark ? module.color.opacity(0.3) : .clear)
                        .stroke(color,lineWidth: 6)
                    
                        .frame(width: GeometryProxy.size.width - 30, height: 140)
                        .padding(.top,10)
                }.frame(maxWidth: .infinity)
                VStack(alignment:.leading){
                    HStack{
                        Text(trip.dateFrom,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(color)
                        Text("-")
                            .font(.headline)
                            .foregroundStyle(color)
                        Text(trip.dateTo,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(color)
                        Spacer()
                        Button {
                            module.tripHistory.remove(at: module.tripHistory.firstIndex(of: trip)!)
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(color)
                        }
                        
                    }.padding(.vertical,7)
                        .padding(.bottom,10)
                    
                    HStack{
                        Text(trip.name == "" ? "Trip" : trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                        Spacer()
                        Text("\(trip.percentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                    }
                    
                }.padding(9)
                    .frame(width: GeometryProxy.size.width - 55, height: 110,alignment: .topLeading)
            }
        }.frame(height: 150)
    }
    @ViewBuilder
    var tripCurrent: some View {
        GeometryReader { GeometryProxy in
            ZStack(alignment: .center) {
                
                VStack(alignment:.center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorScheme == .dark ? module.color.opacity(0.3) : .clear)
                        .stroke(color,lineWidth: 6)
                        
                        .frame(width: GeometryProxy.size.width - 30, height: 140)
                        .padding(.top,10)
                }.frame(maxWidth: .infinity)
                    
                VStack(alignment:.leading){
                    HStack{
                        Text(trip.dateFrom,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(color)
                        Text("-")
                            .font(.headline)
                            .foregroundStyle(color)
                        Text(trip.dateTo,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(color)
                        Spacer()
                        Button {
                            if trip.percentage == 100 {
                                module.tripHistory.append(trip)
                                module.trips.remove(at: module.trips.firstIndex(of: trip)!)
                            } else {
                                module.trips.remove(at: module.trips.firstIndex(of: trip)!)
                            }
                        } label: {
                            Image(systemName: trip.percentage == 100 ? "checkmark":"minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(color)
                        }

                    }.padding(.vertical,7)
                        .padding(.bottom,10)
                    
                    HStack{
                        Text(trip.name == "" ? "Trip" : trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                        Spacer()
                        Text("\(trip.percentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                    }
                    
                }.padding(9)
                .frame(width: GeometryProxy.size.width - 55, height: 110,alignment: .topLeading)
            
               
            }
        }.frame(height: 150)
    }
}

#Preview {
    TripCell(historyView: .constant(true), trip: MockData.tripData,color:.red,module:PackingMockData.packingMock)
}
