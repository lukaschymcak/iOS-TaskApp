//
//  PlantsModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantsModuleOpen: View {
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vmParent = ViewModel()
    

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
                            - (!plantsModuleModel.selectedModule.wateredLocations.isEmpty
                                    ? 65 : 0))

                    VStack(spacing: 0) {

                        HStack {
                            CustomNavBarModule(
                                module: "Plants", name: "Plants")
                            if !plantsModuleModel.selectedModule.wateredLocations.isEmpty {
                                Button {
                                    vmParent.toggleAddingPlants()
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

                        if plantsModuleModel.selectedModule.wateredLocations.isEmpty {
                  
                            VStack(alignment: .center) {
                    
                                Text("Let's water some plants!")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color(hex: "D19252"))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                Button {
                                    vmParent.toggleAddingPlants()
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
                              
                            }
                        } else {
                            ScrollViewReader { ScrollViewProxy in
                                PlantList(
                                ).frame(height: 70)
                                    .environmentObject(vmParent)
                                    .onChange(of: plantsModuleModel.selectedModule.plants) {
                                        vmParent.addAndScrollTo(old: $0, new: $1, scroll: ScrollViewProxy)
                                    }
                            }
                           
                            
                            
                            

                            VStack {

                                PlantListView( vmChild: $vmParent.selectedLocation
                               )
                         
                            }

                        }

                        Spacer()
                    }

                }.frame(maxWidth: .infinity, alignment: .center)

            }
        }.onAppear(perform: {
            vmParent.updateModule(with: plantsModuleModel.selectedModule)
        })
        .fullScreenCover(isPresented: $vmParent.addingPlant) {
            AddingPlantView()

        }
    }
}

extension PlantsModuleOpen{
    
    class ViewModel:ObservableObject {
        @Published var selectedModule : PlantsModuleDataClass = MockPlantsModule.moduleA
        @Published var selectedLocation: houseLocation = .all
        @Published var addingPlant: Bool = false
        
        
        func updateModule(with module: PlantsModuleDataClass){
            
            
            self.selectedModule = module
            
            
        }
        
        func toggleAddingPlants (){
            addingPlant.toggle()
        }
        func selectLocation(location: houseLocation){
            selectedLocation = location
        }
        @MainActor
        func addAndScrollTo(old arr1: [PlantModel],new arr2: [PlantModel],scroll: ScrollViewProxy){
            if arr2.count > arr1.count {
                if let last = arr2.last {
                    selectedLocation = last.location
                    scroll.scrollTo(selectedLocation,anchor: .leading)
                    
                }
            }else if arr2.count < arr1.count {
                if let firstIndex = arr2.first(where: {$0.location == selectedLocation}){
                    selectedLocation = firstIndex.location
                    scroll.scrollTo(selectedLocation,anchor: .leading)
                } else {
                    selectedLocation = .all
                    scroll.scrollTo(selectedLocation,anchor: .leading)
                }
            }
            
        }
        
        
        var sortedByValue: [(key:houseLocation,value:[PlantModel])] {
            return selectedModule.wateredLocations.sorted(by: {
                if $0.value.count == $1.value.count {
                    return $0.key.id < $1.key.id
                } else {
                    return $0.value.count > $1.value.count
                }
            })
        }
            
        
    }
}


#Preview {
    PlantsModuleOpen()
}

