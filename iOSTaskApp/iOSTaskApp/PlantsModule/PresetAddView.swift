//
//  PresetAddView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetAddView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var plantModuleModel: PlantsModuleHomeView.ViewModel
    @State var plantModel:PlantModel
    @State var infoText: String = ""
    @State var selectedDate:Date = Date.now
    @State var location: houseLocation = .bathroom
    @State var frequency: Int = 1
    @State var showOptions: Bool = false
    @Binding var cancelHit:Bool
    @State var isPopupShown:Bool = false
    var body: some View {
        GeometryReader { GeometryProxy in
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.darkGreen)

                    .ignoresSafeArea()
                VStack(spacing:20){
                    HStack {
                        Image(plantModel.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .font(.title)
                        Text(plantModel.name)
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }.frame(maxWidth: .infinity,alignment:.leading)
            
                    ScrollView{
                        Text(infoText)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .lineSpacing(6)
                            .multilineTextAlignment(.leading)
                    }.frame(height: 325)
                    Spacer()
                    
                    
                    
                    
                    
                    
                    
                }.frame(width: GeometryProxy.size.width - 20)
                    .frame(maxWidth: .infinity,alignment: .center)
                
                
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.lightCream)
                        .ignoresSafeArea()
                        .frame(height: 330)

                        .overlay {
                            ZStack {
                                
                                VStack(alignment:.leading,spacing: 15){
                                    HStack {
                                        DatePicker(selection: $selectedDate,in: Date.now..., displayedComponents: .date) {
                                            Text("First Day")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.lightCream)
    
                                            
                                        }
                                        .padding(10)
                                        .background(.darkCream)
                                        .clipShape(.rect(cornerRadius: 10))
                             
                                    }.frame(height: 60)
                                    
                                    HStack(alignment: .center){
                                        Text("Frequency:")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.lightCream)
                                        Spacer()
                                        
                                        
                                        Picker("Frequency",selection: $frequency){
                                            
                                            ForEach((1...30), id: \.self){ num in
                                                Text("\(num.description)").tag(num.description)
                                                
                                                
                                                
                                            }
                                        }.pickerStyle(.wheel)
                                            .frame(width: 100)
                                        Button {
                                            isPopupShown.toggle()
                                        } label: {
                                            Image(systemName: "info.circle.fill")
                                                       .resizable()
                                                       .scaledToFit()
                                                       .frame(width: 20, height: 20)
                                                       .background(.darkCream)
                                                       .foregroundStyle(.lightCream)
                                            
                                                       .popover(isPresented: $isPopupShown, attachmentAnchor: .point(.top),arrowEdge: .bottom) {
                                                           VStack{
                                                               Text("Every X Days")
                                                               Text("e.g  X Days from last watering")
                                                           }
                                                           .multilineTextAlignment(.center)
                                                               .lineLimit(0)
                                                               .foregroundStyle(.lightCream)
                                                               .font(.system(size: 12, weight: .semibold, design: .default))
                                                               .padding(5)
                                                               .presentationCompactAdaptation(.none)
                                                              
                                                       }
                                        }

                                        
                                        
                                 
                                    }.frame(height: 60)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal,10)
                                        .background(.darkCream)
                        
                                        .clipShape(.rect(cornerRadius: 10))
                                    HStack(alignment: .center){
                                        Text("Room:")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.lightCream)
                                        Spacer()
                                        Menu(location.id){
                                            ForEach(houseLocation.allCases){ loc in
                                                Button {
                                                    location = loc
                                                } label: {
                                                    Text(loc.id)
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        .padding(8)
                                        .padding(.horizontal,10)
                                        .foregroundStyle(Color.white)
                                        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.3)))
                                        
                 
                                    }.frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(10)
                                        .background(.darkCream)
                                        .clipShape(.rect(cornerRadius: 10))
                                    
                                    HStack(spacing:15) {
                                        Button {
                                            cancelHit = true
                                            dismiss()
                                            
                                            
                                        } label: {
                                            Text("Cancel")
                                                .font(.title)
                                                .foregroundStyle(.lightCream)
                                                .fontWeight(.bold)
                                                .padding(10)
                                                .background(.darkCream)
                                                .clipShape(.rect(cornerRadius: 10))
                                        }
                                        Button {
                                            let plantModelCopy = PlantModel(name: plantModel.name,desc: plantModel.getDesc(),location:location, frequency: frequency,water: plantModel.water,light:plantModel.light,temp: plantModel.temp,image: plantModel.image,waterDate: selectedDate)
                                            
                                            plantModuleModel.toast = Toast(style: .success, message: "Plant Added",duration: 3)
                                            plantModuleModel.selectedModule.addPlant(a: plantModelCopy)
                                            cancelHit = false
                                            dismiss()
                                            
                                        } label: {
                                            Text("Add Plant")
                                                .font(.title)
                                                .foregroundStyle(.lightCream)
                                                .fontWeight(.bold)
                                                .padding(10)
                                                .background(.darkCream)
                                                .clipShape(.rect(cornerRadius: 10))
                                        }  .sensoryFeedback(.increase, trigger: plantModuleModel.selectedModule.plants.count)
                                       
                                    }.frame(maxWidth: .infinity,alignment: .center)
                                        .padding(.top,10)
                                    Spacer()
                                    
                                    
                                }.padding(.horizontal)
                                    .padding(.top,30)
                                    .presentationDetents([.height(400)])
                                
                                    .presentationCornerRadius(20)
                            }
                   
                            
                        }.frame(maxWidth: .infinity,alignment: .leading)
                        
                }
                
            }.onAppear {
                infoText = plantModel.getDesc()
            }
            
        }
        
        
        
        
        
        
    }
   
    
}


#Preview {
    PresetAddView(plantModel: DefaultPlants.monstera, cancelHit: .constant(true))
        .environmentObject(PlantsModuleHomeView.ViewModel())
}
