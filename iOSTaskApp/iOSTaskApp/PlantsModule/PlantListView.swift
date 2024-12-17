//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @Binding var vmChild: houseLocation
    @State private var toast: Toast? = nil
    
    var body: some View {
        
        
        GeometryReader { GeometryProxy in
            ScrollView(showsIndicators: false){
                NavigationStack{
                    VStack(alignment:.leading){
                        
                        if vmChild == .all{
                            
                            if !plantsVM.selectedModule.getForgottenPlants(location: vmChild).isEmpty{
                                Text("Forgotten:")
                                    .font(.largeTitle)
                                    .foregroundStyle(.lightOrange)
                                    .fontWeight(.bold)
                                    .padding(.top,10)
                                    .padding(.horizontal,10)
                                
                                ForEach(plantsVM.selectedModule.getForgottenPlants(location:  vmChild),id: \.id){ plant in
                                    if !plant.isCustom {
                                        NavigationLink {
                                            PlantDetailView(plantCell: plant)
                                                .environmentObject(plantsVM)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            
                                            PlantCell(plantCell: plant)
                                                .frame(height: 130)
                                        }
                                    } else {
                                        NavigationLink {
                                            CustomPlantDetailView(plantCell: plant)
                                                .environmentObject(plantsVM)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            
                                            PlantCell(plantCell: plant)
                                                .frame(height: 130)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            showAllPlantsByDate(when: .today)
                            showAllPlantsByDate(when: .tomorrow)
                            showAllPlantsByDate(when: .thisWeek)
                            showAllPlantsByDate(when: .afterWeek)
                            
                            
                            
                            
                            
                        } else {
                            if !plantsVM.selectedModule.getForgottenPlants(location: vmChild).isEmpty{
                                Text("Forgotten:")
                                    .font(.largeTitle)
                                    .foregroundStyle(.lightOrange)
                                    .fontWeight(.bold)
                                    .padding(.top,10)
                                    .padding(.horizontal,10)
                                
                                ForEach(plantsVM.selectedModule.getForgottenPlants(location:  vmChild),id: \.id){ plant in
                                    if !plant.isCustom {
                                        NavigationLink {
                                            PlantDetailView(plantCell: plant)
                                                .environmentObject(plantsVM)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            
                                            PlantCell(plantCell: plant)
                                                .frame(height: 130)
                                        }
                                    } else {
                                        NavigationLink {
                                            CustomPlantDetailView(plantCell: plant)
                                                .environmentObject(plantsVM)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            
                                            PlantCell(plantCell: plant)
                                                .frame(height: 130)
                                        }
                                    }
                                    
                                }
                                
                            }
                            showPlantsByDateAndLocation( when: .today, location: vmChild)
                            showPlantsByDateAndLocation( when: .tomorrow, location: vmChild)
                            showPlantsByDateAndLocation( when: .thisWeek, location: vmChild)
                            showPlantsByDateAndLocation( when: .afterWeek, location: vmChild)
                            
                        }
                    }
                }.frame(width: GeometryProxy.size.width - 20)
                    .frame(maxWidth: .infinity,alignment: .center)
                
                
            }
            
        }.toastView(toast: $plantsVM.toast, someAction: {plantsVM.selectedPlants?.unPrepare()})
        
    }
    
    struct showPlantsByDateAndLocation: View {
        @EnvironmentObject var plantsVM: PlantsModuleViewModel
        @State var when: waterTime
        var location: houseLocation
        var body: some View {
            NavigationStack{
                
                VStack(alignment: .leading){
                    if !plantsVM.selectedModule.filterByDateAndLocation(when: when, location:  location).isEmpty{
                        Text(when.rawValue)
                            .font(.largeTitle)
                            .foregroundStyle(.lightOrange)
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,10)
                        ForEach(plantsVM.selectedModule.filterByDateAndLocation(when: when, location:  location),id: \.id){ plant in
                            if !plant.isCustom {
                                NavigationLink {
                                    PlantDetailView(plantCell: plant)
                                        .environmentObject(plantsVM)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant)
                                        .frame(height: 130)
                                }
                            } else {
                                NavigationLink {
                                    CustomPlantDetailView(plantCell: plant)
                                        .environmentObject(plantsVM)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant)
                                        .frame(height: 130)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    struct showAllPlantsByDate: View {
        @EnvironmentObject var plantsVM: PlantsModuleViewModel
        @State var when: waterTime
        var body: some View{
            NavigationStack{
                VStack(alignment: .leading){
                    if !plantsVM.selectedModule.filterByDAte(when: when).isEmpty{
                        Text(when.rawValue)
                            .font(.largeTitle)
                            .foregroundStyle(.lightOrange)
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,10)
                        ForEach(plantsVM.selectedModule.filterByDAte(when: when).sorted(by: { !$0.watered && $1.watered }),id: \.id){ plant in
                            if !plant.isCustom {
                                NavigationLink {
                                    PlantDetailView(plantCell: plant)
                                        .environmentObject(plantsVM)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant)
                                        .frame(height: 130)
                                }
                            } else {
                                NavigationLink {
                                    CustomPlantDetailView(plantCell: plant)
                                        .environmentObject(plantsVM)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant)
                                        .frame(height: 130)
                                }
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
}
#Preview {
    PlantListView(vmChild: .constant(.all))
        .environmentObject(PlantsModuleViewModel())
}
