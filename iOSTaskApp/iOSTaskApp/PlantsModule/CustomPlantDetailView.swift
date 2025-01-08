//
//  CustomPlantDetailView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 05/12/2024.
//

import SwiftUI

struct CustomPlantDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    var plantCell:PlantModel
    @State var showWateringAlert:Bool = false
    @State var setWater:String = ""
    @State var setTemp:String = ""
    @State var setLight:String = ""
    @State var showWaterAlert:Bool = false
    @State var showTempAlert:Bool = false
    @State var showLightAlert:Bool = false
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack{
            
                Color.lightCream
                    .ignoresSafeArea()
                VStack(){
                  
                    HStack {
                        Image(plantCell.image)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .offset(x: -5, y: 5)
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .frame(height: 400,alignment: .top)
                        
                      
                    
                }
       

                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.darkGreen)
                        .ignoresSafeArea()
                        .frame(height:350)
                        .frame(maxHeight: .infinity,alignment: .bottom)
            
                    VStack(alignment: .leading, spacing: 20){
                        Spacer()
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
                                                Text(plantCell.water == "" ? "Tap to add Water" : "\(plantCell.water)")
                                                    .foregroundStyle(.darkGreen)
                                                        .fontWeight(.bold)
                                                        .font(.subheadline)
                                                        
                                                
                                            }.onTapGesture {
                                                showWaterAlert.toggle()
                                            }.alert("Edit Water(ml)", isPresented: $showWaterAlert) {
                                                TextField("Water", text: $setWater)
                                                Button("Add") {
                                                    plantCell.setWater(a: setWater)
                                                }
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
                                                Text("TEMP(c)")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                Text(plantCell.temp == "" ? "Tap to add Temp" : "\(plantCell.temp)")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    
                                            }
                                            .onTapGesture {
                                                showTempAlert.toggle()
                                            }.alert("Edit Temp", isPresented: $showTempAlert) {
                                                TextField("Temp", text: $setTemp)
                                                Button("Add") {
                                                    plantCell.setTemp(a: setTemp)
                                                }
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
                                                Text(plantCell.light == "" ? "Tap to add Light" : "\(plantCell.light)")
                                                    .foregroundStyle(.darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    
                                            } .onTapGesture {
                                                showLightAlert.toggle()
                                            }.alert("Edit Light", isPresented: $showLightAlert) {
                                                TextField("Light", text: $setLight)
                                                Button("Add") {
                                                    plantCell.setTemp(a: setLight)
                                                }
                                            }
                                        
                                        }.frame(maxWidth: 140,alignment: .leading)
                                            .padding(.horizontal)
                                            
                                 
                                    }
                            }
                        }

                        HStack {
                            wateringButton
                        }.frame(maxWidth: .infinity,alignment: .center)
                            .padding(.bottom,10)
                            .padding(.top,10)
                           
                    }.frame(width: GeometryProxy.size.width - 50)
                    
                       
                   

                   
                
                }
            }
        }.ignoresSafeArea(.keyboard)
            .customBackBar(title: "Plants", textColor: .darkGreen) {
                dismiss()
            }
    }
    @ViewBuilder
    var wateringButton: some View {
       
        if Calendar.current.isDateInToday(plantCell.waterDate) || plantCell.waterDate.isBeforeToday() {
            Button {
                if plantCell.waterDate.isBeforeToday() {
                    showWateringAlert.toggle()
                    dismiss()
                    
                }else {
                    plantCell.prepare()
                    plantsVM.toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                    plantsVM.selectedPlants = plantCell
                    dismiss()
                }
            } label: {
                Image(
                    systemName: plantCell.prepared
                    ? "checkmark.circle" : "drop.circle"
                )
                .font(.system(size: 50))
                .foregroundStyle(.lightCream)
            }.padding(.horizontal)
                .alert(isPresented: $showWateringAlert) {
                    Alert(title: Text("Water Plant ?"), primaryButton: .destructive(Text("You forgot to water this plant , once watered next watering date will be calculated from today"), action: {
                        plantCell.prepare()
                        plantsVM.toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                        plantsVM.selectedPlants = plantCell
                    }) , secondaryButton: .cancel())
                }.disabled(plantCell.prepared)
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
    CustomPlantDetailView( plantCell: DefaultPlants.africanViolet)
}
