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
                        .fill(Color(hex: "606C38"))
                        .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "FEFAE0"))
                        .ignoresSafeArea()
                        .frame(
                            height: GeometryProxy.size.height
                                - (!plantsModule.wateredLocations.isEmpty
                                    ? 160 : 0))

                    VStack {

                        HStack {
                            CustomNavBarModule(
                                module: "Plants", name: "Plants")
                            if !plantsModule.wateredLocations.isEmpty {
                                Button {
                                    addingPlant.toggle()
                                } label: {
                                    ZStack {
                                        Image("pot")
                                            .resizable()
                                            .frame(width: 50, height: 50)

                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .fontWeight(.bold)
                                            .foregroundStyle(
                                                Color(hex: "EFD0CA")
                                            )
                                            .offset(x: -1, y: 0)
                                    }
                                }

                            }
                        }.padding(.bottom, 20)
                            .frame(width: GeometryProxy.size.width - 30)
                            .frame(maxWidth: .infinity, alignment: .center)

                        if plantsModule.wateredLocations.isEmpty {
                            VStack {
                                Text("Let's water some plants!")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color(hex: "D19252"))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .padding()
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
                                            .foregroundStyle(.white)
                                            .offset(x: -1, y: 9)

                                    }

                                }
                            }.padding(.top, 50)
                        } else {
                            PlantList(
                                plantsModule: plantsModule,
                                selectedLocation: $selectedLocation
                            )
                            .frame(height: 80)
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
        GeometryReader { GeometryProxy in

            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 15) {

                        ForEach(
                            plantsModule.wateredLocations.sorted(by: {
                                if $0.value.count == $1.value.count {
                                    return $0.key.id < $1.key.id
                                } else {
                                    return $0.value.count > $1.value.count
                                }
                            }), id: \.key
                        ) { location, value in

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
                                            Color(hex: "C77F3C"),
                                            lineWidth: selectedLocation
                                                == location ? 5 : 0
                                        )
                                        .frame(height: 50)

                                        Text(location.rawValue)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(
                                                Color(hex: "C77F3C")
                                            )
                                            .background(.clear)
                                            .padding(8)

                                    }
                                }
                                if value.filter({ $0.prepared == false }).count
                                    > 0
                                {
                                    Circle()
                                        .fill(
                                            .red
                                        )
                                        .frame(
                                            width: 20,
                                            height: 20
                                        )
                                        .overlay {
                                            Text(
                                                "\(value.filter({$0.prepared == false}).count)  "
                                            )
                                            .foregroundStyle(
                                                .white
                                            )
                                            .padding(1)

                                        }.offset(x: 151, y: -15)

                                }

                            }.frame(height: 60)

                        }

                    }
                }.padding(.trailing, 18)
                    .padding(.leading, 8)
                    .padding(.vertical, 5)

            }.clipShape(.rect(cornerRadius: 20))
                .background(
                    RoundedRectangle(cornerRadius: 20).fill(
                        Color(hex: "FEFAE0"))
                )
                .frame(width: UIScreen.main.bounds.width - 30)
                .frame(maxWidth: .infinity, alignment: .center)

        }
    }
}

#Preview {
    PlantsModuleOpen(plantsModule: MockPlantsModule.moduleA)
}
1
