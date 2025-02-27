//
//  PlantDetailView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/11/2024.
//

import SwiftUI

struct PlantDetailView: View {
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    var colums: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Environment(\.dismiss) var dismiss
    var plantCell:PlantModel
    @State var showWaterAlert:Bool = false
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack{
        
                Color.lightCream
                    .ignoresSafeArea()
                VStack {
                    
                    HStack {
                        Image(plantCell.image)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .offset(x: -5, y: 5)
                    }.frame(maxWidth: GeometryProxy.size.width ,alignment: .center)
                        .frame(maxHeight: .infinity,alignment: .top)
                }
       

                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.darkGreen)
                        .ignoresSafeArea()
                        .frame(height: 560)
                        .frame(maxHeight: .infinity,alignment: .bottom)
               
                    VStack(alignment: .leading, spacing: 20){
                        Text(plantCell.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.lightCream)
                
                            
                        VStack{
                            HStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(.lightCream)
                                    .overlay {
                                        HStack{
                                            Image(systemName: "calendar")
                                                .foregroundStyle(.darkGreen)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("FREQUENCY")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                Text("Every \(plantCell.frequency) days")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    
                                            }
                                        }
                                    }
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(.lightCream)
                                    .overlay {
                                        HStack{
                                            Image(systemName: "drop")
                                                .foregroundStyle(.darkGreen)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("WATER(ml)")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                Text(plantCell.water)
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                            }
                                        }
                                        .frame(maxWidth: 140,alignment: .leading)
                                        .padding(.horizontal)
                                    }
                            }
                            HStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(.lightCream)
                                    .overlay {
                                        HStack{
                                            Image(systemName: "thermometer.transmission")
                                                .foregroundStyle(.darkGreen)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("TEMP(C)")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                Text(plantCell.temp)
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                            }
                                        }.frame(maxWidth: 140,alignment: .leading)
                                            .padding(.horizontal)
                                        
                                    }
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(.lightCream)
                                    .overlay {
                                        HStack{
                                            
                                            Image(systemName: "sun.max")
                                                .foregroundStyle(.darkGreen)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("LIGHT")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                ScrollView(.horizontal,showsIndicators: false){
                                                    Text(plantCell.light)
                                                        .foregroundStyle(.darkGreen)
                                                        .fontWeight(.bold)
                                                        .font(.footnote)
                                                }.frame(height: 5)
                                            }
                                        }.frame(maxWidth: 140,alignment: .leading)
                                            .padding(.horizontal)
                                    }
                            }
                        }
                        ScrollView(showsIndicators: false){
                            Text(plantCell.getDesc())
                                .font(.title2)
                                .foregroundStyle(.lightCream)
                            
             
                        }
                            .frame(height: 220,alignment: .top)
                        HStack {
                            wateringButton
                        }.frame(maxWidth: .infinity,alignment: .center)
                           
                    }.frame(width: GeometryProxy.size.width - 50,height: GeometryProxy.size.height,alignment: .bottom)
                    
                       
                   

                   
                
                }
            }
        }.customBackBar(title: "Plants", textColor: .darkGreen) {
            dismiss()
        }
            
            
        }
    @ViewBuilder
    var wateringButton: some View {
        
        if Calendar.current.isDateInToday(plantCell.waterDate)
            || plantCell.waterDate.isBeforeToday()
        {
            Button {
                if plantCell.waterDate.isBeforeToday() {
                    showWaterAlert.toggle()

                } else {
                    plantCell.toggleWatered()
                    plantCell.waterPlantAndIncreaseDate()
                    plantsVM.toast = Toast(
                        style: .success, message: NSLocalizedString("Plant Watered", comment: ""),
                        doOutsideFunctonImage: "arrow.uturn.backward")
                    plantsVM.selectedPlants = plantCell

                }
            } label: {
                HStack {
                    Text(showWaterAlert.description)

                }.frame(width: 0, height: 0)
                Image(
                    systemName: plantCell.watered
                        ? "checkmark.circle" : "drop.circle"
                )
                .font(.system(size: 50))
                .foregroundStyle(.lightCream)
            }.padding(.horizontal)
                .alert(LocalizedStringKey("Water ?"), isPresented: $showWaterAlert, actions: {
                    
                    Button(LocalizedStringKey("Yes")) {
                        plantCell.toggleWatered()
                        plantCell.waterPlantAndIncreaseDate()
                        plantsVM.toast = Toast(
                            style: .success, message: NSLocalizedString("Plant Watered", comment: ""),
                            doOutsideFunctonImage:
                                "arrow.uturn.backward")
                        plantsVM.selectedPlants = plantCell
                    
                    }
                    Button("No", role: .cancel) {
                    }
                }, message: {
                    Text(LocalizedStringKey("You forgot to water this plant , once watered next watering date will be calculated from today"))
                })
                .disabled(plantCell.watered)
        } else {
            Image(
                systemName: "clock"
            )
            .font(.system(size: 50))
            .foregroundStyle(.lightCream)
            .padding(.horizontal)
        }
    }
    
}


#Preview {
    PlantDetailView(plantCell: DefaultPlants.monstera )
        .environmentObject(PlantsModuleViewModel())
}
