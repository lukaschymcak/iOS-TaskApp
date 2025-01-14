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
    @State private var cardOffset = CGSize.zero

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
            ZStack(alignment: .trailing) {
                ZStack {
                    
                    VStack(alignment:.center) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "1E6091"))
                        
                        
                            .frame(width: GeometryProxy.size.width - 40, height: 140)
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
                            }.alert(LocalizedStringKey("delete_trip"), isPresented: $showDeleteAlert) {
                                Button(LocalizedStringKey("yes"), role: .destructive) {
                                    toast = Toast(style: .success, message: NSLocalizedString("trip_deleted", comment: ""))
                                    module.removeHistoryTrip(a: trip)
                                }
                            } message: {
                                Text(LocalizedStringKey("trip_delete_history_warning"))
                            }
                            
                            
                        }.padding(.vertical,7)
                            .padding(.bottom,10)
                        
                        HStack{
                            Text(trip.name == "" ? NSLocalizedString("trip", comment: "") : trip.name)
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
                }.dragToDelete(cardOffset: $cardOffset) {
                    toast = Toast(style: .success, message: NSLocalizedString("trip_deleted", comment: ""))
                    module.removeHistoryTrip(a: trip)
                }
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
                    .deleteCardSlow(cardOffset: $cardOffset, customHeight: 140)
            }
        }.frame(height: 140)
       
            
    }
    @ViewBuilder
    var tripCurrent: some View {
        GeometryReader { GeometryProxy in
            ZStack(alignment:.trailing){
                ZStack(alignment: .center) {
                    
                    VStack(alignment:.center) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "1E6091"))
                        
                            .frame(width: GeometryProxy.size.width - 40, height: 140)
                        
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
                            }.alert(LocalizedStringKey("complete_trip"), isPresented: $showAddToHistoryAlert, actions: {
                                Button(LocalizedStringKey("confirm"), role: .destructive) {
                                    toast = Toast(style: .success, message: NSLocalizedString("added_history", comment: ""))
                                    module.addTripHistory(a: trip)
                                    module.removeTrip(a: trip)
                                }
                            }, message: {
                                Text(LocalizedStringKey("add_trip_history_warning"))
                            }
                            ).alert(LocalizedStringKey("delete_trip"), isPresented: $showDeleteAlert, actions: {
                                Button("Yes", role: .destructive) {
                                    toast = Toast(style: .success, message: NSLocalizedString("trip_deleted", comment: ""))
                                    module.removeTrip(a: trip)
                                }
                            }, message: {
                                Text(LocalizedStringKey("trip_delete_warning"))
                                
                                
                            })
                            
                            
                        }.padding(.vertical,7)
                            .padding(.bottom,10)
                        
                        HStack{
                            Text(trip.name == "" ? NSLocalizedString("trip", comment: "") : trip.name)
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
                    
                    
                }.dragToDelete(cardOffset: $cardOffset) {
                    toast = Toast(style: .success, message: NSLocalizedString("trip_deleted", comment: ""))
                    module.removeTrip(a: trip)
                }
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
                    .deleteCardSlow(cardOffset: $cardOffset, customHeight: 140)
            }
        }.frame(height: 140)
    }
}

