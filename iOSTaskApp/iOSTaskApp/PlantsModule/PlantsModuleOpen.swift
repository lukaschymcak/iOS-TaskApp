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
                VStack {

                    HStack {
                        CustomNavBarModule(module: "Packing", name: "Plant")

                    }.padding(.top, 10)
                        .frame(width: GeometryProxy.size.width - 30)
                        .frame(maxWidth: .infinity, alignment: .center)
              
                    Button {
                        for plants in plantsModule.plants {
                            plants.toggleNotWatered()
                        }
                    } label: {
                        Image(systemName:"arrow.clockwise" )
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { proxy in
                            HStack(spacing: 15) {

                                ForEach(
                                    plantsModule.wateringLocations.sorted(by: {
                                        $0.key.id < $1.key.id
                                    }), id: \.key
                                ) { location, number in

                                    ZStack(alignment: .trailing) {

                                        Button {
                                            withAnimation {
                                                proxy.scrollTo(
                                                    location, anchor: .center)
                                                selectedLocation = location
                                            }

                                        } label: {
                                            ZStack {
                                                if selectedLocation == location
                                                {
                                                    RoundedRectangle(
                                                        cornerRadius: 20
                                                    )
                                                    .stroke(
                                                        plantsModule.color,
                                                        lineWidth: 5
                                                    )
                                                    .frame(height: 50)

                                                }
                                                Text("\(location.id)")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(
                                                        plantsModule.color
                                                    )
                                                    .background(.clear)
                                                    .padding(8)

                                            }
                                        }
                                        if number > 0 {
                                            Circle()
                                                .fill(plantsModule.color)
                                                .frame(width: 20, height: 20)
                                                .overlay {
                                                    Text("\(number)")
                                                        .foregroundStyle(.white)
                                                        .padding(1)

                                                }
                                                .offset(x: 10, y: -15)
                                        }
                                    }.frame(height: 60)

                                }

                            }
                        }.padding(.horizontal)

                    }.frame(width: GeometryProxy.size.width - 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    plantsModule.color.frame(
                        width: GeometryProxy.size.width - 30, height: 5
                    )
                    .clipShape(.rect(cornerRadius: 20))
                    VStack {

                        PlantListView(
                            plantsModule: plantsModule,
                            location: selectedLocation)

                    }
                    Spacer()
                    VStack {
                        Button {
                            addingPlant.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Utils.textColor(colorScheme))
                                .padding()

                        }

                    }
                }

            }.frame(maxWidth: .infinity, alignment: .center)
        }.sheet(isPresented: $addingPlant) {
            AddingPlantView(plantsModule: plantsModule)

        }
    }
}

#Preview {
    PlantsModuleOpen(plantsModule: MockPlantsModule.moduleA)
}
