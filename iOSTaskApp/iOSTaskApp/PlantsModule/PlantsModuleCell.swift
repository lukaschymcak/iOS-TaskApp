//
//  PlantsModuleCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantsModuleCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State var plantsModule:PlantsModuleDataClass
    @Environment(\.modelContext) var context
    @State var showAlert:Bool = false
    var body: some View {
  
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? plantsModule.color.opacity(0.3) : .clear)
                    .stroke(plantsModule.color,lineWidth: 7)
                    .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight:
                            plantsModule.plants.isEmpty ? 150 : 180)
                
                VStack{
                    VStack(alignment: .leading,spacing: 10) {
                        HStack {
                            Text(plantsModule.name == "" ? "Plants" :
                                    plantsModule.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(plantsModule.color)
                            Spacer()
                            Button {
                                showAlert.toggle()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(plantsModule.color)
                            }.alert(isPresented: $showAlert){
                                Alert(title: Text("Remove module ?") ,message: Text("This will delete all your plants"),primaryButton: .destructive(Text("Confirm") ,action: {
                                    context.delete(plantsModule)
                                    context.insert(DefaultModules.plants)
                                }),secondaryButton: .cancel())
                            }
                           
                            
                            
                        }
                        Text("\(plantsModule.needWatering) plants need watering today")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(plantsModule.color)
                        ScrollView(.horizontal){
                            HStack(spacing: 20){
                      
                                ForEach(plantsModule.wateringLocations.sorted(by: { $0.value > $1.value }),id: \.key) { location,number  in
                                    VStack{
                                        Text("\(location.id)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(plantsModule.color)
                                        Text("\(number)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(plantsModule.color)
                                    }
                                    
                                }
                            }
                        }
                     
             
                    }.padding(.horizontal,8)
               
           
                 
                }.frame(maxWidth: UIScreen.main.bounds.width - 55)
            }.padding(.vertical,20)
        }
    
}

#Preview {
    PlantsModuleCell( plantsModule: MockPlantsModule.moduleA)
        .modelContainer(for:PlantsModuleDataClass.self)
}
