//
//  PlantDetailView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/11/2024.
//

import SwiftUI

struct PlantDetailView: View {
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
    var colums: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Environment(\.dismiss) var dismiss
    var plantCell:PlantModel
    @State var showWaterAlert:Bool = false
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
                                                Text("WATER")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text(plantCell.water)
                                                    .foregroundStyle(Color(hex: "606C38"))
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
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .overlay {
                                        HStack{
                                            Image(systemName: "thermometer.transmission")
                                                .foregroundStyle(Color(hex: "606C38"))
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            VStack(alignment: .leading){
                                                Text("TEMP")
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                Text(plantCell.temp)
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                    .font(.subheadline)
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
                                                Text(plantCell.light)
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                    .fontWeight(.bold)
                                                    .font(.footnote)
                                                    
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
                    showWaterAlert.toggle()
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
                .alert(isPresented: $showWaterAlert) {
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

struct plantDetailBoxes:View {
    var plantCell:PlantModel
    var image:String
    var title:String
    var body: some View {
        HStack{
                Image(systemName: "calendar")
                    .foregroundStyle(Color(hex: "606C38"))
                    .fontWeight(.bold)
                    .font(.title2)
                VStack{
                    Text("FREQUENCY")
                        .foregroundStyle(Color(hex: "606C38"))
                        .fontWeight(.bold)
                    Text("Every \(plantCell.frequency) days")
                        .foregroundStyle(Color(hex: "606C38"))
                        .fontWeight(.bold)
                        
                }
            }
        }
    
}
#Preview {
    PlantDetailView(plantCell: DefaultPlants.monstera )
        .environmentObject(PlantsModuleHomeView.ViewModel())
}
