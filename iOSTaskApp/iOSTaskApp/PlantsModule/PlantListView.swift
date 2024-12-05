//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
    @Binding var vmChild: houseLocation
    @State private var toast: Toast? = nil
    
    var body: some View {
        
        
        GeometryReader { GeometryProxy in
            ScrollView(showsIndicators: false){
                NavigationStack{
                VStack(alignment:.leading){
          
                        if vmChild == .all{
                            Text("All:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)
                            
                            ForEach(plantsModuleModel.selectedModule.getAllPlants(),id: \.id){ plant in
                                NavigationLink {
                                    PlantDetailView(plantCell: plant)
                                        .environmentObject(plantsModuleModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant )
                                        .frame(height: 130)
                                }

                            }
                            
                        } else {
                            if !plantsModuleModel.selectedModule.getForgottenPlants(location: vmChild).isEmpty{
                                Text("Forgotten:")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color(hex: "C77F3C"))
                                    .fontWeight(.bold)
                                    .padding(.top,10)
                                    .padding(.horizontal,10)
                                
                                ForEach(plantsModuleModel.selectedModule.getForgottenPlants(location:  vmChild),id: \.id){ plant in
                                    NavigationLink {
                                        PlantDetailView(plantCell: plant)
                                            .environmentObject(plantsModuleModel)
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        
                                        PlantCell(plantCell: plant )
                                            .frame(height: 130)
                                    }
                                    
                                }
                                
                            }
                            showPlantsByDateAndLocation( when: .today, location: $vmChild)
                            showPlantsByDateAndLocation( when: .tomorrow, location: $vmChild)
                            showPlantsByDateAndLocation( when: .thisWeek, location: $vmChild)
                            showPlantsByDateAndLocation( when: .afterWeek, location: $vmChild)
                            
                        }
                    }
                }.frame(width: GeometryProxy.size.width - 20)
                    .frame(maxWidth: .infinity,alignment: .center)
                  
       
            }
            
        }.toastView(toast: $plantsModuleModel.toast, someAction: {plantsModuleModel.selectedPlants?.unPrepare()})
    }
   
    struct showPlantsByDateAndLocation: View {
        @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
        @State var when: waterTime
        @Binding var location: houseLocation
        var body: some View {
            NavigationStack{
                
                VStack(alignment: .leading){
                    if !plantsModuleModel.selectedModule.filterByDateAndLocation(when: when, location:  location).isEmpty{
                        Text(when.rawValue)
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: "C77F3C"))
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,10)
                        ForEach(plantsModuleModel.selectedModule.filterByDateAndLocation(when: when, location:  location),id: \.id){ plant in
                            if !plant.isCustom {
                                NavigationLink {
                                    PlantDetailView(plantCell: plant)
                                        .environmentObject(plantsModuleModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    
                                    PlantCell(plantCell: plant)
                                        .frame(height: 130)
                                }
                            } else {
                                NavigationLink {
                                    CustomPlantDetailView(plantCell: plant)
                                        .environmentObject(plantsModuleModel)
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
        .environmentObject(PlantsModuleHomeView.ViewModel())
}
