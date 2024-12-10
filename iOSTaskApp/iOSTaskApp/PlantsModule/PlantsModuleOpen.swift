//
//  PlantsModuleOpen.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantsModuleOpen: View {
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vmParent = ViewModel()
    @Environment(\.dismiss) var dismiss
    @AppStorage("isPlantsOnboardingShown") var isPlantsOnboardingShown: Bool = true
    

    var body: some View {
        NavigationStack {
            GeometryReader { GeometryProxy in
                ZStack(alignment: .bottom) {

                    RoundedRectangle(cornerRadius: 30)
                        .fill(.darkGreen)
                        .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 30)
                        .fill(.lightCream)
                        .ignoresSafeArea()
                        .frame(
                            height: GeometryProxy.size.height
                            - (!plantsVM.selectedModule.wateredLocations.isEmpty
                                    ? 85 : 0))

                    VStack(spacing: 0) {
                        
                      
                        if plantsVM.selectedModule.wateredLocations.isEmpty {
                            VStack {
                            }.onAppear {
                                vmParent.addingPlant = true
                            }
                        } else {
                            ScrollViewReader { ScrollViewProxy in
                                PlantList(
                                ).frame(height: 70)
                                    .environmentObject(vmParent)
                                    .onChange(of: plantsVM.selectedModule.plants) {
                                        vmParent.addAndScrollTo(old: $0, new: $1, scroll: ScrollViewProxy)
                                    }.padding()
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
            vmParent.updateModule(with: plantsVM.selectedModule)
        })
        .fullScreenCover(isPresented: $vmParent.addingPlant) {
            AddingPlantView()
                .environmentObject(plantsVM)    
   
        }.customBackBar(title: "Plants", textColor: plantsVM.selectedModule.plants.isEmpty ? .darkGreen : .lightCream) {
            dismiss()
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
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
                                .lightCream
                            )
                            .offset(x: -1, y: 0)
                    }
                    
                    
                }
            }
        }.sheet(isPresented: $isPlantsOnboardingShown) {
            PlantsOnboarding()
        }
    }
}

extension PlantsModuleOpen{
    
    class ViewModel:ObservableObject {
        @Published var selectedModule : PlantsModuleDataClass = MockPlantsModule.moduleA
        @Published var selectedLocation: houseLocation = .all
        @Published var addingPlant: Bool = false
        @Published var toast: Toast?
        
        
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
        .environmentObject(PlantsModuleViewModel())
}


