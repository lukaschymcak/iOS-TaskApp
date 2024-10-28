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
                            
                            showDeleteAlert.toggle()
           
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(color)
                        }.alert(isPresented: $showDeleteAlert) {
                            Alert(title: Text("Are you sure"), message: Text("delete"),
                                  primaryButton: .destructive(Text("yes"), action: {
                                toast = Toast(style: .success, message: "Trip deleted from history")
                            
                                module.removeHistoryTrip(a: trip)
                              
                         
                            }),secondaryButton: .cancel())
                            
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
                                showAddToHistoryAlert.toggle()
                                showDeleteAlert.toggle()
                            } else {
                                showDeleteAlert.toggle()
                               
                            }
                        } label: {
                            Image(systemName: trip.percentage == 100 ? "checkmark":"minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(color)
                        }.alert(isPresented: $showDeleteAlert) {
                            if showAddToHistoryAlert {
                                Alert(title: Text("Complete trip ?"), message: Text("This will complete the trip , and add it to your history"), primaryButton: .destructive(Text("Confirm"), action: {
                                    toast = Toast(style: .success, message: "Added to history")
                                    module.addTripHistory(a: trip)
                       
                                    module.removeTrip(a: trip)
                               
                                }) , secondaryButton: .cancel())
                            }else {
                                Alert(title: Text("Are you sure"), message: Text("delete"),
                                      primaryButton: .destructive(Text("yes"), action: {
                                    toast = Toast(style: .success, message: "Trip succesfully deleted")
                         
                                    module.removeTrip(a: trip)
                              
                                }),secondaryButton: .cancel())
                            }
                            
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

