//
//  AddingCustomPlantView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 05/12/2024.
//

import SwiftUI

struct AddingCustomPlantView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @State var infoText: String = ""
    @State var plantName: String = ""
    @State var selectedDate:Date = Date.now
    @State var location: houseLocation = .bathroom
    @State var frequency: Int = 1
    @State var isPopupShown:Bool = false
    @State var showOptions: Bool = false
    @State var selectedImage: String = ""
    @Binding var cancelHit: Bool
    var body: some View {
        
        
        GeometryReader { geo in
            VStack(alignment:.leading,spacing: 15){
                HStack {
                    Text("Name:")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.lightCream)
                        .padding(10)
                    
                        .clipShape(.rect(cornerRadius: 10))
                    TextField("Plant", text: $plantName)
                        .textFieldStyle(.roundedBorder)
                        .padding(10)
                    
                }.frame(height: 60)
                    .background(.creamOrange)
                    .clipShape(.rect(cornerRadius: 10))
                HStack {
                    DatePicker(selection: $selectedDate,in: Date.now..., displayedComponents: .date) {
                        Text("First Day")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.lightCream)
                        
                        
                    }
                    .padding(10)
                    .background(.creamOrange)
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
                            .background(.creamOrange)
                            .foregroundStyle(.lightCream)
                        
                            .popover(isPresented: $isPopupShown, attachmentAnchor: .point(.top),arrowEdge: .bottom) {
                                VStack{
                                    Text("Every X Days")
                                    Text("e.g  X Days from last watering")
                                }
                                .multilineTextAlignment(.center)
                                .lineLimit(0)
                                .foregroundStyle(.creamOrange)
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .padding(.horizontal,10)
                                .presentationCompactAdaptation(.none)
                                
                            }
                    }
                    
                    
                    
                    
                }.frame(height: 60)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,10)
                    .background(.creamOrange)
                
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
                                Text(loc.localizedString())
                                
                            }
                            
                            
                        }
                        
                    }
                    .padding(8)
                    .padding(.horizontal,10)
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.3)))
                    
                    
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(10)
                    .background(.creamOrange)
                    .clipShape(.rect(cornerRadius: 10))
                VStack {
                    Text("Choose an Image :")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.lightCream)
                    ScrollViewReader{ proxy in
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(DefaultPlants.plantImages, id: \.self){ image in
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightCream,lineWidth: selectedImage == image ? 4 : 0)
                                        .fill(.creamOrange)
                                        .frame(width: 60, height: 60)
                                        .overlay {
                                            Image(image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            
                                        }.padding(3)
                                        .onTapGesture {
                                            
                                            selectedImage = image
                                            proxy.scrollTo(image, anchor: .center)
                                            
                                            
                                        }
                                    
                                }
                            }
                        }
                    }
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(10)
                    .background(.creamOrange)
                    .clipShape(.rect(cornerRadius: 10))
                
                
                
                HStack(spacing:15) {
                    Button {
                        
                        dismiss()
                        cancelHit = true
                        
                    } label: {
                        Text("Cancel")
                            .font(.title)
                            .foregroundStyle(.lightCream)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(.creamOrange)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    Button {
                        
                        let customPlant = PlantModel(name: plantName == "" ? "Plant" : plantName,location: location, frequency: frequency, image: selectedImage == "" ? "african-violet" : selectedImage, waterDate: selectedDate,isCustom: true)
                        plantsVM.selectedModule.addPlant(a: customPlant)
                        plantsVM.toast = Toast(style: .success, message: "Plant Added", duration: 2)
                        dismiss()
                        cancelHit = false
                        
                    } label: {
                        Text("Add Plant")
                            .font(.title)
                            .foregroundStyle(.lightCream)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(.creamOrange)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    
                }.frame(maxWidth: .infinity,alignment: .center)
                    .padding(.top,10)
                Spacer()
                
                
            }.padding(.horizontal)
                .padding(.top,30)
                .presentationDetents([.height(600)])
            
                .presentationCornerRadius(20)
                .foregroundStyle(.lightCream)
        }.ignoresSafeArea(.keyboard)
    }
}

#Preview {
    AddingCustomPlantView( cancelHit: .constant(false))
        .environmentObject(PlantsModuleViewModel())
        
}
