//
//  CustomPlantDetailView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 05/12/2024.
//

import SwiftUI

struct CustomPlantDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
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
        
                Color(hex: "FEFAE0")
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Button{
                            dismiss()
                        }label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color(hex: "606C38"))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                
                        }
                        Spacer()
                    }.frame(width: GeometryProxy.size.width - 30)
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
                        .fill(Color(hex: "606C38"))
                        .ignoresSafeArea()
                        .frame(height: 560)
                        .frame(maxHeight: .infinity,alignment: .bottom)
               
                    VStack(alignment: .leading, spacing: 20){
                        Text(plantCell.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                
                            
                        VStack{
                            HStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .overlay {
                                        HStack{
                                            Image(systemName: "calendar")
                                                .foregroundStyle(Color(hex: "606C38"))
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("FREQUENCY")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text("Every \(plantCell.frequency) days")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
                                                    
                                            }
                                        }
                                    }
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 80)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .overlay {
                                        HStack{
                                            Image(systemName: "drop")
                                                .foregroundStyle(Color(hex: "606C38"))
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("WATER(ml)")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text(plantCell.water == "" ? "Tap to add Water" : "\(plantCell.water)")
                                                        .foregroundStyle(Color(hex: "606C38"))
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
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .overlay {
                                        HStack{
                                            Image(systemName: "thermometer.transmission")
                                                .foregroundStyle(Color(hex: "606C38"))
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("TEMP(C)")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text(plantCell.temp == "" ? "Tap to add Temp" : "\(plantCell.temp)")
                                                    .foregroundStyle(Color(hex: "606C38"))
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
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .overlay {
                                        HStack{
                                            Image(systemName: "sun.max")
                                                .foregroundStyle(Color(hex: "606C38"))
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("LIGHT")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text(plantCell.light == "" ? "Tap to add Light" : "\(plantCell.light)")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                    .font(.footnote)
                                                    
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
                        ScrollView(showsIndicators: false){
                            Text(plantCell.getDesc())
                                .font(.title2)
                                .foregroundStyle(Color(hex: "FEFAE0"))
                            
             
                        }
                            .frame(height: 220,alignment: .top)
                        HStack {
                            wateringButton
                        }.frame(maxWidth: .infinity,alignment: .center)
                           
                    }.frame(width: GeometryProxy.size.width - 50,height: GeometryProxy.size.height,alignment: .bottom)
                    
                       
                   

                   
                
                }
            }
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
                    plantsModuleModel.toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                    plantsModuleModel.selectedPlants = plantCell
                    dismiss()
                }
            } label: {
                Image(
                    systemName: plantCell.prepared
                    ? "checkmark.circle" : "drop.circle"
                )
                .font(.system(size: 50))
                .foregroundStyle(Color(hex: "FEFAE0"))
            }.padding(.horizontal)
                .alert(isPresented: $showWateringAlert) {
                    Alert(title: Text("Water Plant ?"), primaryButton: .destructive(Text("You forgot to water this plant , once watered next watering date will be calculated from today"), action: {
                        plantCell.prepare()
                        plantsModuleModel.toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                        plantsModuleModel.selectedPlants = plantCell
                    }) , secondaryButton: .cancel())
                }.disabled(plantCell.prepared)
        } else {
            Image(
                systemName: "clock"
            )
            .font(.system(size: 50))
            .foregroundStyle(Color(hex: "FEFAE0"))
            .padding(.horizontal)
        }
    }
}

#Preview {
    CustomPlantDetailView( plantCell: MockPlants.plantA)
}
