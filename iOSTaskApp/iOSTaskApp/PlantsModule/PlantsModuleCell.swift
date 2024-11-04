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
                    .fill(Color(hex: "FEFAE0"))
                    .stroke(Color(hex: "606C38"),lineWidth: 7)
                    .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight:
                            plantsModule.plants.isEmpty ? 180 : 180)
                
                VStack{
                    VStack(alignment: .leading,spacing: 15) {
                        HStack {
                            Text(plantsModule.name == "" ? "Plants" :
                                    plantsModule.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "606C38"))
                            Spacer()
                            Button {
                                showAlert.toggle()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "606C38"))
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
                            .foregroundStyle(Color(hex: "606C38"))
                        ScrollView(.horizontal,showsIndicators: false){
                            if !plantsModule.wateredLocations.isEmpty {
                                
                                HStack(spacing: 20){
                                    
                                    ForEach(plantsModule.wateredLocations.sorted(by: { $0.value.count > $1.value.count }).filter({ (key: houseLocation, value: [PlantModel]) in
                                        value.allSatisfy { PlantModel in
                                            !PlantModel.prepared
                                        }
                                    }),id: \.key.id) { location , value  in
                                            VStack{
                                                Text("\(location.id)")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                Text("\(value.count)")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color(hex: "606C38"))
                                            }
                                            
                                        
                                    }
                                }
                            }
                        }
                     
             
                    }.padding(.horizontal,8)
               
           
                 
                }  .padding(.vertical,20)
                .frame(maxWidth: UIScreen.main.bounds.width - 55)
                  
            }
        }
    
}

#Preview {
    PlantsModuleCell( plantsModule: MockPlantsModule.moduleA)
        .modelContainer(for:PlantsModuleDataClass.self)
}
