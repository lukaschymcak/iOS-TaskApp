//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    var plantsModule: PlantsModuleDataClass
    var location: houseLocation
    var body: some View {
        
        GeometryReader { GeometryProxy in
            ScrollView{
                VStack(alignment:.leading){
                    if !self.getForgottenPlants(a: plantsModule.filterByLocation(a: location)).isEmpty{
                            Text("Forgotten:")
                                .font(.title)
                                .fontWeight(.bold)
                            ForEach(self.getForgottenPlants(a: plantsModule.filterByLocation(a: location)),id: \.self){ plant in
                                PlantCell(plantModule: plantsModule, plantCell: plant, color: plantsModule.color)
                                    .frame(height: 130)
                                
                            }
                        
                    }
                    if !self.getTodayPlants(a: plantsModule.filterByLocation(a: location)).isEmpty{
                        Text("Today")
                            .font(.title)
                            .fontWeight(.bold)
                        ForEach(self.getTodayPlants(a: plantsModule.filterByLocation(a: location)),id: \.self){ plant in
                            PlantCell(plantModule: plantsModule, plantCell: plant, color: plantsModule.color)
                                .frame(height: 130)
                            
                        }
                    }
                    if let weekPlants = self.getWeekPlants(a: plantsModule.filterByLocation(a: location)) {
                        if !weekPlants.isEmpty{
                            Text("in the next 5 days:")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top,10)
                            ForEach(weekPlants,id: \.self){ plant in
                                PlantCell(plantModule: plantsModule, plantCell: plant, color: plantsModule.color)
                                    .frame(height: 130)
                            }
                        }
                    }
                    if let restPlants = self.getRestPlants(a: plantsModule.filterByLocation(a: location)){
                        if !restPlants.isEmpty{
                            Text("more than 5 days:")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top,10)
                            ForEach(restPlants,id: \.self){ plant in
                                PlantCell(plantModule: plantsModule, plantCell: plant, color: plantsModule.color)
                                    .frame(height: 130)
                            }
                        }
                    }
                    
                }.frame(width: GeometryProxy.size.width - 50)
                    .frame(maxWidth: .infinity,alignment: .center)
            }
            
        }
    }
   
   
    func getForgottenPlants(a:[PlantModel]) -> [PlantModel]{
        return a.filter { plant in
            plant.waterDate.isBeforeToday()
        }.sorted { $0.waterDate < $1.waterDate}
        }

    func getTodayPlants(a:[PlantModel]) -> [PlantModel]{
        return a.filter { plant in
            plant.waterDate.isToday()
        }
    }
    
    func getWeekPlants(a:[PlantModel]) -> [PlantModel]?{
        let today = Date.now
        let nextWeek = Calendar.current.date(byAdding: .day, value: 5, to: today)
        if let nextWeek = nextWeek {
         return   a.filter { plant in
                plant.waterDate > today && plant.waterDate < nextWeek
         }.sorted { $0.waterDate < $1.waterDate}
        }
        return nil
    }
    func getRestPlants(a:[PlantModel]) -> [PlantModel]?{
        let today = Date.now
        let nextWeek = Calendar.current.date(byAdding: .day, value: 5, to: today)
        if let nextWeek = nextWeek {
         return   a.filter { plant in
             plant.waterDate > nextWeek
         }.sorted { $0.waterDate < $1.waterDate}
        }
        return nil
    }
    
}
#Preview {
    PlantListView(plantsModule: MockPlantsModule.moduleA,location: .bathroom)
}
