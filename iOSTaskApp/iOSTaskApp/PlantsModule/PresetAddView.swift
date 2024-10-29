//
//  PresetAddView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetAddView: View {
    @State var color: Color = .green
    @State var plantModule: PlantsModuleDataClass
    @State var plantModel:PlantModel
    @State var infoText: String = ""
    @State var selectedDate:Date = Date.now
    @State var location: houseLocation = .bathroom
    @State var frequency: Int = 1
    var body: some View {
        GeometryReader { GeometryProxy in
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(0.4))
                VStack{
                    HStack {
                        Image(systemName: plantModel.image)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Text(plantModel.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }.padding()
                    ScrollView{
                        Text(infoText)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .lineSpacing(6)
                    }
                    Spacer()
                    HStack(spacing:20){
                        
                        
                        Button {
                            infoText = plantModel.getDesc()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color.opacity(0.4),lineWidth: 5)
                                .fill(.white)
                                .frame(width: 100, height: 50)
                                .overlay {
                                    Text("Info")
                                        .foregroundStyle(color)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    
                                }
                        }
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color.opacity(0.4),lineWidth: 5)
                                .fill(.white)
                                .frame(width: 100, height: 50)
                                .overlay {
                                    Text("Water")
                                        .foregroundStyle(color)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    
                                    
                                }
                        }
                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color.opacity(0.4),lineWidth: 5)
                                .fill(.white)
                                .frame(width: 100, height: 50)
                                .overlay {
                                    Text("Light")
                                        .foregroundStyle(color)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                    
                                }
                        }
                        
                        
                        
                        
                    }.padding(.bottom,305)
                    
                    
                    
                    
                    
                    
                    
                }.frame(width: GeometryProxy.size.width - 50)
                    .frame(maxWidth: .infinity,alignment: .center)
                
                
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(height: 285)
                        .overlay {
                            
                            VStack(alignment:.leading,spacing: 15){
                                DatePicker(selection: $selectedDate,in: Date.now..., displayedComponents: .date) {
                                    Text("First Day")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                                .datePickerStyle(.compact)
                                .padding(10)
                                .background(color.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 10))
                                
                                HStack(alignment: .center){
                                    Text("Frequency:")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Text("every")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Picker("Frequency",selection: $frequency){
                                        
                                        ForEach((1...30), id: \.self){ num in
                                            Text("\(num.description)").tag(num.description)
                                            
                                            
                                            
                                        }
                                    }.pickerStyle(.automatic)
                                    
                                    
                                    Text("\(frequency > 1 ?"days": "day")")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                }.frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(10)
                                    .background(color.opacity(0.4))
                                    .clipShape(.rect(cornerRadius: 10))
                                HStack(alignment: .bottom){
                                    Text("Room:")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Picker("Bathroom", selection: $location) {
                                        
                                        Text("Bathroom").tag(houseLocation.bathroom)
                                        Text("Bedroom").tag(houseLocation.bedroom)
                                        Text("Dining Room").tag(houseLocation.diningRoom)
                                        Text("Kitchen").tag(houseLocation.kitchen)
                                        
                                    }
                                    
                                    
                                    
                                }.frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(10)
                                    .background(color.opacity(0.4))
                                    .clipShape(.rect(cornerRadius: 10))
                                
                                HStack {
                                    Button {
                                        let plantModelCopy = PlantModel(name: plantModel.name,desc: plantModel.getDesc(),location:location, frequency: frequency,waterDate: selectedDate)
                                       
                                        
                                        plantModule.addPlants(a: plantModelCopy)
                           
                                        
                                    } label: {
                                        Text("Add")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                            .frame(width: 100,height: 50)
                                            .background(color.opacity(0.4))
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
                                }.frame(maxWidth: .infinity,alignment: .center)
                                    .padding(.top,10)
                                
                            }.padding(.horizontal)
                                .padding(.top,20)
                            
                            
                            
                            
                        }.frame(maxWidth: .infinity,alignment: .leading)
                }
                
            }.onAppear {
                infoText = plantModel.getDesc()
            }
            
        }
        
        
        
        
        
        
    }
    
}


#Preview {
    PresetAddView(plantModule: MockPlantsModule.moduleA, plantModel: DefaultPlants.monstera)
}
