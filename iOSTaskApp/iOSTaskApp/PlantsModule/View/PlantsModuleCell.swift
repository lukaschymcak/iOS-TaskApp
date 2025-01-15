//
//  PlantsModuleCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI
import SwiftData
struct PlantsModuleCell: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @StateObject var vm = ViewModel()
    @AppStorage("swipreToDeleteInfo") var swipeToDelete: Bool = false

    @State private var cardOffset = CGSize.zero

    
    @Environment(\.modelContext) var context
    var body: some View {
        
                
                
                
        VStack {
            ZStack(alignment: .trailing) {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.lightGreen)
             
                        .frame(maxWidth: UIScreen.main.bounds.width )
                        .frame(height: 190)
                        .overlay {
                            VStack{
                                VStack(alignment: .leading,spacing: plantsVM.selectedModule.needWatering > 0 ? 10 : 20){
                                    HStack {
                                        Image("aloe-vera")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .padding(.trailing,8)
                                       
                                        Text("Plants")
                                            .font(.system(size: 35))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.lightCream)
                                        Spacer()
                                    
                                        
                                        
                                        
                                    }
                                    Text(LocalizedStringKey("\(plantsVM.selectedModule.needWatering) plants need watering"))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.lightCream)
                                
                                    
                                    ScrollView(.horizontal,showsIndicators: false){
                                        if plantsVM.selectedModule.needWatering > 0 {
                                            
                                            HStack(spacing: 20){
                                                
                                                ForEach(plantsVM.filteredPlants,id: \.key.id) { location , value  in
                                                    
                                                    
                                                    VStack{
                                                        Text(location.localizedString())
                                                            .font(.headline)
                                                            .fontWeight(.bold)
                                                            .foregroundStyle(.lightCream)
                                                        Text("\(value.filter({$0.watered == false && $0.waterDate.isToday() || $0.waterDate.isBeforeToday()}).count)")
                                                            .font(.title2)
                                                            .fontWeight(.bold)
                                                            .foregroundStyle(.lightCream)
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                    
                                }.padding(.horizontal,8)
                                    .padding(.top,10)

                                
                                
                                
                            }.frame(maxWidth: UIScreen.main.bounds.width - 55)
                        }
                    
                    
                       
                    
                } .frame(maxWidth: .infinity)
                
                
            }.frame(maxWidth: .infinity)
                
         
        }.frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom,5)
            
           
                
                
            
            
        }
    }

extension PlantsModuleCell {
    class ViewModel: ObservableObject {
        @Published var selectedModule: PlantsModuleDataClass = MockPlantsModule.moduleA

        @Published var showAlert:Bool = false
        
        
        func updatePlants(with plant: PlantsModuleDataClass){
            selectedModule = plant
        }
    
        
        var filteredPlants: [(key:houseLocation,value:[PlantModel])] {
          
            return selectedModule.wateredLocations.filter({$0.value.filter({$0.watered == false && $0.waterDate.isToday() || $0.waterDate.isBeforeToday()}).count > 0})
            
        }
        
      
    }
}
#Preview {
    PlantsModuleCell(vm: PlantsModuleCell.ViewModel())
        .modelContainer(for:PlantsModuleDataClass.self)
        .environmentObject(PlantsModuleViewModel())
}
