//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
    @State var plant: PlantModel?
    @Binding var vmChild: houseLocation
    @State private var toast: Toast? = nil
    
    var body: some View {
        
        
        GeometryReader { GeometryProxy in
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading){
                    if vmChild == .all{
                        Text("All:")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: "C77F3C"))
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,10)
                        
                        ForEach(plantsModuleModel.getAllPlants(),id: \.id){ plant in
                            PlantCell(selectedPlant: $plant, plantCell: plant, toast: $toast)
                                .frame(height: 130)
                        }
                        
                    } else {
                        if !plantsModuleModel.getForgottenPlants(location: vmChild).isEmpty{
                            Text("Forgotten:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)
                            
                            ForEach(plantsModuleModel.getForgottenPlants(location:  vmChild),id: \.id){ plant in
                                PlantCell( selectedPlant: $plant, plantCell: plant, toast: $toast)
                                    .frame(height: 130)
                                
                            }
                            
                        }
                        if !plantsModuleModel.filterByDateAndLocation(when: .today, location:  vmChild).isEmpty{
                            Text("Today:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,5)
                            
                            
                            ForEach(plantsModuleModel.filterByDateAndLocation(when: .today, location:  vmChild),id: \.id){ plant in
                                        PlantCell(selectedPlant: $plant, plantCell: plant,toast: $toast)
                                            .frame(height: 130)
                                    }
                                
                            
                        }
                        if !plantsModuleModel.filterByDateAndLocation(when: .tomorrow, location:  vmChild).isEmpty{
                            Text("Tommorow:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)
                            
                            ForEach(plantsModuleModel.filterByDateAndLocation(when: .tomorrow, location:  vmChild),id: \.id){ plant in
                                PlantCell(selectedPlant: $plant, plantCell: plant,toast: $toast)
                                    .frame(height: 130)
                                
                            }
                        }
                        if  !plantsModuleModel.filterByDateAndLocation(when: .thisWeek, location:  vmChild).isEmpty{
                         
                                Text("This Week:")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color(hex: "C77F3C"))
                                    .fontWeight(.bold)
                                    .padding(.top,10)
                                    .padding(.horizontal,10)
                                
                                ForEach(plantsModuleModel.filterByDateAndLocation(when: .thisWeek, location:  vmChild),id: \.id){ plant in
                                    PlantCell( selectedPlant: $plant, plantCell: plant,  toast: $toast)
                                        .frame(height: 130)
                                }
                            
                        }
                        if !plantsModuleModel.filterByDateAndLocation(when: .afterWeek, location:  vmChild).isEmpty{
         
                                Text("After this week:")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color(hex: "C77F3C"))
                                    .fontWeight(.bold)
                                    .padding(.top,10)
                                    .padding(.horizontal,10)
                                ForEach(plantsModuleModel.filterByDateAndLocation(when: .afterWeek, location:  vmChild),id: \.id){ plant in
                                    PlantCell( selectedPlant: $plant, plantCell: plant, toast: $toast)
                                        .frame(height: 130)
                                }
                            
                        }
                    }
                    
                }.frame(width: GeometryProxy.size.width - 20)
                    .frame(maxWidth: .infinity,alignment: .center)
       
            }
            
        }.toastView(toast: $toast, someAction: {plant?.unPrepare()})
    }
   
   

    
    
}
#Preview {
    PlantListView(vmChild: .constant(.all))
}
