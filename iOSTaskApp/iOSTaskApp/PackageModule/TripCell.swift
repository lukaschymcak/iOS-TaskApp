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
    @State var showDeleteAlert:Bool = false
    @State var showAddToHistoryAlert:Bool = false
    @State var module:PackingModuleDataClass
    @Binding var toast: Toast? 

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
            ZStack {
                
                VStack(alignment:.center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "1E6091"))
        
                    
                        .frame(width: GeometryProxy.size.width - 40, height: 140)
                        .padding(.top,10)
                }.frame(maxWidth: .infinity)
                VStack(alignment:.leading){
                    HStack{
                        Text(trip.dateFrom,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Text("-")
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Text(trip.dateTo,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Spacer()
                        Button {
                            
                            showDeleteAlert.toggle()
           
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "FEFAE0"))
                        }.alert("Delete Trip ?", isPresented: $showDeleteAlert) {
                            Button("Yes", role: .destructive) {
                                toast = Toast(style: .success, message: "Trip succesfully deleted")
                                module.removeHistoryTrip(a: trip)
                            }
                        } message: {
                            Text("This will delete the trip from your history")
                        }

                        
                    }.padding(.vertical,7)
                        .padding(.bottom,10)
                    
                    HStack{
                        Text(trip.name == "" ? "Trip" : trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Spacer()
                        Text("\(trip.percentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "FEFAE0"))
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
                        .fill(Color(hex: "1E6091"))
                        
                        .frame(width: GeometryProxy.size.width - 30, height: 140)
                        .padding(.top,10)
                }.frame(maxWidth: .infinity)
                    
                VStack(alignment:.leading){
                    HStack{
                        Text(trip.dateFrom,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Text("-")
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Text(trip.dateTo,format: .dateTime.day().month().year())
                            .font(.headline)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Spacer()
                        Button {
                            if trip.percentage == 100 {
                                showAddToHistoryAlert.toggle()
                            } else {
                                showDeleteAlert.toggle()
                            }
                        } label: {
                            Image(systemName: trip.percentage == 100 ? "checkmark":"minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "FEFAE0"))
                        }.alert("Complete Trip?", isPresented: $showAddToHistoryAlert, actions: {
                            Button("Confirm", role: .destructive) {
                                toast = Toast(style: .success, message: "Added to history")
                                module.addTripHistory(a: trip)
                                module.removeTrip(a: trip)
                            }
                        }, message: {
                            Text("This will complete the trip , and add it to your history")
                        }
                        ).alert("Delete Trip ?", isPresented: $showDeleteAlert, actions: {
                            Button("Yes", role: .destructive) {
                                toast = Toast(style: .success, message: "Trip succesfully deleted")
                                module.removeTrip(a: trip)
                            }
                        }, message: {
                            Text("This will delete the trip")
                        
                            
                        })
     

                    }.padding(.vertical,7)
                        .padding(.bottom,10)
                    
                    HStack{
                        Text(trip.name == "" ? "Trip" : trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                        Spacer()
                        Text("\(trip.percentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                    }
                    
                }.padding(9)
                .frame(width: GeometryProxy.size.width - 55, height: 110,alignment: .topLeading)
            
               
            }
        }.frame(height: 150)
    }
}

