//
//  PlantsModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantsModuleOpen: View {
    var plantsModule: PlantsModuleDataClass
    @Environment(\.colorScheme) var colorScheme
    @State var selectedLocation: houseLocation = .bathroom
    @State var addingPlant: Bool = false
    var body: some View {
        NavigationStack {
            GeometryReader { GeometryProxy in
                ZStack(alignment: .bottom) {

                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "9DA091"))
                        .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "5C7457"))
                        .ignoresSafeArea()
                        .frame(height: GeometryProxy.size.height - 135)

                    VStack {

                        HStack {
                            CustomNavBarModule(
                                module: "Packing", name: "Plants")

                        }.padding(.top, 10)
                            .frame(width: GeometryProxy.size.width - 30)
                            .frame(maxWidth: .infinity, alignment: .center)

                        if plantsModule.wateredLocations.isEmpty {
                            Text("No Rooms found. Add a plant first")
                                .font(.title2)
                                .foregroundStyle(Color(hex: "EFD0CA"))
                                .fontWeight(.bold)
                                .padding()
                            Text("Let's water some plants!")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "EFD0CA"))
                                .fontWeight(.bold)
                                .padding(30)
                                .multilineTextAlignment(.leading)
                        } else {
                            PlantList(plantsModule: plantsModule, selectedLocation: $selectedLocation)
                                .onChange(of: plantsModule.plants) { _, newValue in
                                    if let first = newValue.last {
                                        selectedLocation = first.location
                                    }
                                }
                           
                            VStack {

                                PlantListView(
                                    plantsModule: plantsModule,
                                    location: selectedLocation)

                            }

                        }

                        Spacer()
                    }

                    Button {
                        addingPlant.toggle()
                    } label: {
                        ZStack {
                            Image("pot")
                                .resizable()
                                .frame(width: 100, height: 100)

                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "EFD0CA"))
                                .offset(x: -1, y: 10)

                        }

                    }
                }.frame(maxWidth: .infinity, alignment: .center)

            }
        }.fullScreenCover(isPresented: $addingPlant) {
            AddingPlantView(plantsModule: plantsModule)

        }
    }
}
struct PlantList: View {
    var plantsModule: PlantsModuleDataClass
    @Binding var selectedLocation: houseLocation
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 15) {
                    
                    ForEach(
                        plantsModule.wateredLocations.sorted(by: { if $0.value.count == $1.value.count {
                            return $0.key.id < $1.key.id
                        } else {
                            return $0.value.count > $1.value.count
                        }
 })
                           
                        , id: \.key
                    ) { location, value   in
                        
                        ZStack(alignment: .trailing) {
                            
                            Button {
                                withAnimation {
                                    proxy.scrollTo(
                                        location,
                                        anchor: .center)
                                    selectedLocation =
                                    location
                                }
                                
                            } label: {
                                ZStack {
                                  
                                        RoundedRectangle(
                                            cornerRadius: 20
                                        )
                                        .stroke(
                                            Color(
                                                hex:
                                                    "EFD0CA"
                                            ),
                                            lineWidth: selectedLocation == location ? 5 : 0
                                        )
                                        .frame(height: 50)
                                    
                                   
                                    Text(location.rawValue)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(
                                            Color(
                                                hex:
                                                    "EFD0CA"
                                            )
                                        )
                                        .background(.clear)
                                        .padding(8)
                                    
                                }
                            }
               
                                Circle()
                                    .fill(
                                        Color(hex: "EFD0CA")
                                    )
                                    .frame(
                                        width: 20,
                                        height: 20
                                    )
                                    .overlay {
                                        Text("\(value.count)")
                                            .foregroundStyle(
                                                .white
                                            )
                                            .padding(1)
                                        
                                    }
                                    .offset(x: 10, y: -15)
                            
                        }.frame(height: 60)
                        
                    }
                    
                }
            }.padding(.horizontal)
            
        }
            .frame(maxWidth: .infinity, alignment: .center)
            .clipShape(.rect(cornerRadius: 20))
        
    }
}

#Preview {
    PlantsModuleOpen(plantsModule: MockPlantsModule.moduleA)
}
