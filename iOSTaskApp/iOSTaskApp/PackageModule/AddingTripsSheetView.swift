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
    @Query private var trips:[Trip]
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
                    context.insert(tripData)
                    dismiss()
                } label: {
                    Text("Add")
                }
                
                Spacer()
            }
                .presentationDetents([.height(350)])
        }
    }

#Preview {
    AddingTripsSheetView(tripData: MockData.tripData)
        .modelContainer(for:Trip.self)
    
    
    
}
