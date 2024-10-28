//
//  AddingPlantView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct AddingPlantView: View {
    @State var plantsModule: PlantsModuleDataClass
    @Environment(\.colorScheme) var colorScheme
    @State var presetView: Bool = true
    var body: some View {
        NavigationStack{
            VStack{
                if presetView{
                    Text("Choose a preset plant")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .padding(.top,30)
                    
                    ScrollView{
                        VStack(spacing:20){
                            ForEach(DefaultPlants.presetPlants) { plant in
                                NavigationLink {
                                    Text(plant.name)
                                } label: {
                                    PresetViewCell(plantCell: plant)
                                }
                                
                                
                                
                                
                            }
                        }.padding(.top,20)
                    }
                    
                } else {
                    Text("Add a plant")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .padding(.top,30)
                }
            }
            Spacer()
            
            ZStack(alignment:.leading){
                
                HStack{
                    Button {
                        presetView = true
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.clear)
                            .stroke(plantsModule.color,lineWidth: presetView ? 7:0)
                            .frame(width: 120, height: 40)
                            .overlay {
                                Text("Preset")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                    .padding()
                            }
                        
                    }
                    Button {
                        presetView = false
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.clear)
                            .stroke(plantsModule.color,lineWidth: presetView ? 0:7)
                            .frame(width: 140, height: 40)
                            .overlay {
                                Text("Custom")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                    .padding()
                            }
                    }
                    
                }
            }
        }
    }
}
struct addPresetPlant: View {
    var body: some View {
        Text("Hello")
    }
}
struct addCustomPlant: View {
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    AddingPlantView(plantsModule: MockPlantsModule.moduleA)
}
