//
//  PresetAddView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetAddView: View {
    @State var color: Color = .green
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
                    Text(infoText)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .lineSpacing(6)
                    Spacer()
                    HStack(spacing:20){
    
                            
                            Button {
                                infoText = plantModel.getDesc()
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(color.opacity(0.9),lineWidth: 5)
                                    .fill(.white)
                                    .frame(width: 100, height: 50)
                                    .overlay {
                                        Text("Info")
                                            .foregroundStyle(color)
                                            .fontWeight(.bold)
                                     
                                        
                                    }
                            }
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(color.opacity(0.9),lineWidth: 5)
                                    .fill(.white)
                                    .frame(width: 100, height: 50)
                                    .overlay {
                                        Text("Water")
                                            .foregroundStyle(color)
                                            .fontWeight(.bold)
                                    
                                        
                                    }
                            }
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(color.opacity(0.9),lineWidth: 5)
                                    .fill(.white)
                                    .frame(width: 100, height: 50)
                                    .overlay {
                                        Text("Light")
                                            .foregroundStyle(color)
                                            .fontWeight(.bold)
                                        
                                        
                                    }
                            }

                            
                            
                            
                        }.padding(.bottom,220)
                    
                    
                       
                   
                    
                  
               
                }.frame(width: GeometryProxy.size.width - 50)
                    .frame(maxWidth: .infinity,alignment: .center)
         
        
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(height: 190)
                        .overlay {
                            HStack {
                                VStack(alignment:.leading){
                                    DatePicker(selection: $selectedDate,in: Date.now..., displayedComponents: .date) {
                                        Text("First Day")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }.frame(width: 230)
                                    .datePickerStyle(.compact)
                                    HStack{
                                        Text("Select Frequency:")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("every")
                                        Picker("Frequency",selection: $frequency){
                                
                                                ForEach((1...30), id: \.self){ num in
                                                    Text("\(num.description)").tag(num.description)
                                                   
                                                
                                                
                                            }
                                        }.pickerStyle(.automatic)
                                         
                                        Text("\(frequency > 1 ?"days": "day")")
                                            
                                    }
                                    HStack{
                                        Text("Location:")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        
                                        Picker("Bathroom", selection: $location) {
                                            Text("Bathroom").tag(houseLocation.bathroom)
                                            Text("Bedroom").tag(houseLocation.bedroom)
                                            Text("Dining Room").tag(houseLocation.diningRoom)
                                            Text("Kitchen").tag(houseLocation.kitchen)
                                        }.pickerStyle(.menu)

                                    }
                                }.padding()
                   
                            }.frame(maxWidth: .infinity,alignment: .leading)
                        }
               
                }
                
            }
          
        }
      
         
           

        }

    }


#Preview {
    PresetAddView(plantModel: DefaultPlants.monstera)
}
