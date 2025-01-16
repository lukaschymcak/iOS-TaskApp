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
    var module:PackingModuleDataClass
    @StateObject var vm  = AddingTripsSheetView.ViewModel()
    @State var name = ""
    @State var dateFrom = Date.now
    @State var dateTo = Date.now
    var body: some View {
        GeometryReader { GeometryProxy in
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
                Text("Adding trip")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                HStack{
                    Text("Name:")
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("Enter trip", text: $vm.name)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom,20)
                HStack {
                    VStack(alignment:.leading){
                        HStack{
                            DatePicker(selection: $vm.dateFrom,in: Date.now..., displayedComponents: .date) {
                                Text("From:")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                            }.frame(width: 230)
                            .datePickerStyle(.compact)
                            
                        }
    
                        .padding(.bottom,10)
                        HStack{
                            DatePicker(selection: $vm.dateTo,in: Date.now..., displayedComponents: .date) {
                                Text("To:")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                            }.frame(width: 230)
                                .datePickerStyle(.compact)
                            
                            
                        } .frame(maxWidth: .infinity,alignment: .leading)

                            .padding(.bottom,10)
                    }
                    Button {
                      
                        vm.addATrip( module: module)
                        dismiss()
                        
                    } label: {
                        Text("Add")
                            .padding(13)
                            .font(.title2)
                            .fontWeight(.bold)
                            .background(.orange)
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(.white)
                            .accessibilityIdentifier("addTripButton")
                           
                           
                    }.padding(.horizontal)
                        .sensoryFeedback(.increase, trigger: module.trips.count)
                }

              
                
                Spacer()
            }
            .frame(width: GeometryProxy.size.width - 40)
            .frame(maxWidth: .infinity,alignment: .center)
                .presentationDetents([.height(320)])
        }
         
        }
    }

extension AddingTripsSheetView {
    class ViewModel: ObservableObject{
        @Published var name = ""
        @Published var dateFrom = Date.now
        @Published var dateTo = Date.now
        
        
        func addATrip( module: PackingModuleDataClass){
            let trip = Trip(name: name, dateFrom: dateFrom, dateTo: dateTo,module: module)
            module.addTrip(a: trip)
            module.sortTrips()
            
        }
    }
}

#Preview {
    AddingTripsSheetView(module: PackingMockData.packingMock)
        .modelContainer(for:Trip.self)
    
    
    
}
