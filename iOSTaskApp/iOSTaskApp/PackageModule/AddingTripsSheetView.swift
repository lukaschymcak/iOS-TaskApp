//
//  AddingTripsSheetView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import SwiftUI
import SwiftData

struct AddingTripsSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State var tripData = Trip(name: "", dateFrom: Date.now, dateTo: Date.now)
    var module:PackingModuleDataClass
    var body: some View {
            VStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
                .padding(.top,30)
                .padding(.bottom,5)
                Text("Adding Trip")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                HStack{
                    Text("Name:")
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("", text: $tripData.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(.gray)
                        .clipShape(.rect(cornerRadius: 15))
                }
                .padding(.horizontal, 20)
                .padding(.bottom,20)
                HStack{
                    DatePicker(selection: $tripData.dateFrom,in: Date.now..., displayedComponents: .date) {
                        Text("From:")
                            .font(.title)
                            .fontWeight(.bold)
                    }.datePickerStyle(.compact)
                        .padding(.trailing,100)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom,10)
                HStack{
                    DatePicker(selection: $tripData.dateTo,in: Date.now..., displayedComponents: .date) {
                        Text("To:")
                            .font(.title)
                            .fontWeight(.bold)
                    }.datePickerStyle(.compact)
                        .padding(.trailing,100)
                }
                .padding(.horizontal, 20)
                .padding(.bottom,10)

                Button {
                    let trip = Trip(name: tripData.name, dateFrom: tripData.dateFrom, dateTo: tripData.dateTo,module: module)
                    module.trips.append(trip)
                    module.trips.sort(by: {$0.dateTo < $1.dateTo})
                    dismiss()
                } label: {
                    Text("Add")
                        .padding()
                        .font(.title2)
                        .fontWeight(.bold)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 20))
                        .foregroundStyle(.white)
                       
                       
                }.padding(5)
                
                Spacer()
            }
                .presentationDetents([.height(350)])
        }
    }

#Preview {
    AddingTripsSheetView(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
    
    
    
}
