//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    var plantsModule: PlantsModuleDataClass
    @State var plant: PlantModel?
    var location: houseLocation
    @State private var toast: Toast? = nil
    var body: some View {
        
        GeometryReader { GeometryProxy in
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading){
                    if !plantsModule.getForgottenPlants(location: location).isEmpty{
                            Text("Forgotten:")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)
                 
                        ForEach(plantsModule.getForgottenPlants(location: location),id: \.self){ plant in
                            PlantCell(plantModule: plantsModule, selectedPlant: $plant, plantCell: plant, color: plantsModule.color, toast: $toast)
                                    .frame(height: 130)
                                
                            }
                        
                    }
                    if !plantsModule.getTodayPlants(location: location).isEmpty{
                        Text("Today:")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: "C77F3C"))
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,5)
                    
                        ForEach(plantsModule.wateredLocations.filter({$0.key == location}),id: \.key.id){ location, value in
                            ForEach(value){ plant in
                                if Calendar.current.isDateInToday(plant.waterDate){
                                    PlantCell(plantModule: plantsModule, selectedPlant: $plant, plantCell: plant, color: plantsModule.color, toast: $toast)
                                        .frame(height: 130)
                                }
                            }
                        }
                    }
                    if !self.plantsModule.getTmrwPlants(location: location).isEmpty{
                        Text("Tommorow:")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: "C77F3C"))
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .padding(.horizontal,10)
                    
                        ForEach(plantsModule.getTmrwPlants(location: location),id: \.self){ plant in
                            PlantCell(plantModule: plantsModule, selectedPlant: $plant, plantCell: plant, color: plantsModule.color, toast: $toast)
                                .frame(height: 130)
                            
                        }
                    }
                    if let weekPlants = plantsModule.getWeekPlants(location: location) {
                        if !weekPlants.isEmpty{
                            Text("This Week:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)

                            ForEach(weekPlants,id: \.self){ plant in
                                PlantCell(plantModule: plantsModule, selectedPlant: $plant, plantCell: plant, color: plantsModule.color, toast: $toast)
                                    .frame(height: 130)
                            }
                        }
                    }
                    if let restPlants = plantsModule.getRestPlants(location: location){
                        if !restPlants.isEmpty{
                            Text("After this week:")
                                .font(.largeTitle)
                                .foregroundStyle(Color(hex: "C77F3C"))
                                .fontWeight(.bold)
                                .padding(.top,10)
                                .padding(.horizontal,10)
                            ForEach(restPlants,id: \.self){ plant in
                                PlantCell(plantModule: plantsModule, selectedPlant: $plant, plantCell: plant, color: plantsModule.color, toast: $toast)
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
    PlantListView(plantsModule: MockPlantsModule.moduleA,location: .bathroom)
}
