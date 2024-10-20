//
//  TripCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import SwiftUI

struct TripCell: View {
    @Environment(\.modelContext) var context
    let trip:Trip
    var color:Color = .orange
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color,lineWidth: 6)
                    .frame(width: GeometryProxy.size.width - 45, height: 130,alignment: .center)
                    .padding(.horizontal,25)
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
                        Button {
                            context.delete(trip)
                        } label: {
                            Image(systemName: "minus")
                        }

                    }.padding(.vertical,7)
                        .padding(.bottom,10)
                    
                    HStack{
                        Text(trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                        Spacer()
                        Text(" bags")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                    }
                    
                }
                .frame(width: GeometryProxy.size.width - 80, height: 110,alignment: .topLeading)
            
               
            }
        }.frame(height: 150)
            
    }
}

#Preview {
    TripCell(trip: MockData.tripData)
}
