//
//  ListTripView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import SwiftData
import SwiftUI

struct ListTripView: View {
    @EnvironmentObject var vmChild: PackingModuleOpen.ViewModel
    @Namespace private var namespace
    @State var module: PackingModuleDataClass
    @State private var toast: Toast? = nil
    var body: some View {

        if vmChild.openingHistory {
            showHistory
        } else {
            showCurrent
        }
    }
    @ViewBuilder
    var showHistory: some View {
        GeometryReader { GeometryProxy in

            VStack {
                HStack {
                    Text("HISTORY:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 15)
                        .foregroundStyle(Color(hex: "22577A"))

                    Spacer()
                   

                }.frame(
                    width: GeometryProxy.size.width - 30, alignment: .leading
                )
                .frame(maxWidth: .infinity)

                NavigationStack {

                    ScrollView {
                        if module.tripHistory == [] {
                            Text("History is empty")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color(hex: "22577A"))
                                .font(.headline)
                                .fontWeight(.bold)
                        } else {
                            ForEach(
                                module.tripHistory.sorted(by: {
                                    $0.dateTo < $1.dateTo
                                }), id: \.id
                            ) { trip in

                                NavigationLink {
                                    BagsView(
                                        historyView: $vmChild.openingHistory,
                                        trip: trip
                                    )
                                    .navigationBarBackButtonHidden(true)
                                } label: {
                                    TripCell(
                                        historyView: $vmChild.openingHistory,
                                        trip: trip, module: module,
                                        toast: $toast
                                    )
                             

                                }
                          

                            }

                        }

                    }

                }

            }.toastView(toast: $toast) {

            }
        }

    }
    @ViewBuilder
    var showCurrent: some View {
        GeometryReader { GeometryProxy in

            VStack {
                HStack {
                    Text("MY TRIPS:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 15)
                        .foregroundStyle(Color(hex: "22577A"))

                    Spacer()
                    Button {
                        vmChild.addingTrip.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.orange)
                    }

                }.frame(
                    width: GeometryProxy.size.width - 30, alignment: .leading
                )
                .frame(maxWidth: .infinity)

                NavigationStack {

                    ScrollView {

                        if module.trips == [] {
                            Text("Add a trip to see details")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color(hex: "22577A"))
                                .font(.headline)
                                .fontWeight(.bold)
                        } else {
                            ForEach(
                                module.trips.sorted(by: {
                                    $0.dateTo < $1.dateTo
                                }), id: \.id
                            ) { trip in

                                NavigationLink {
                                    BagsView(
                                        historyView: $vmChild.openingHistory,
                                        trip: trip
                                    )
                                    .navigationTransition(
                                        .zoom(sourceID: "world", in: namespace)
                                    )
                                    .navigationBarBackButtonHidden(true)
                                } label: {
                                    TripCell(
                                        historyView: $vmChild.openingHistory,
                                        trip: trip, module: module,
                                        toast: $toast
                                    )
                                    .animation(
                                        .linear, value: vmChild.openingHistory
                                    )
                                    .transition(.move(edge: .leading))

                                }
                                .animation(
                                    .linear, value: vmChild.openingHistory
                                )
                                .transition(.move(edge: .leading))

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
    ListTripView(module: PackingMockData.packingMock)
        .environmentObject(PackingModuleOpen.ViewModel())

}
