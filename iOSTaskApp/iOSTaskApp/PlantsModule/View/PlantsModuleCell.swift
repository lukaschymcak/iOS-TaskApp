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
    @EnvironmentObject var plantsModule: PlantsModuleHomeView.ViewModel
    @StateObject var vm = ViewModel()

    
    @Environment(\.modelContext) var context
    var body: some View {
        
                
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "FEFAE0"))
                        .stroke(Color(hex: "606C38"),lineWidth: 7)
                        .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight:
                                plantsModule.selectedModule.plants.isEmpty ? 130 : 180)
                    
                    VStack{
                        VStack(alignment: .leading,spacing: 15) {
                            HStack {
                                Text(plantsModule.selectedModule.getName())
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "606C38"))
                                Spacer()
                                Button {
                                    vm.showAlert.toggle()
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "606C38"))
                                }.alert(isPresented: $vm.showAlert){
                                    Alert(title: Text("Remove module ?") ,message: Text("This will delete all your plants"),primaryButton: .destructive(Text("Confirm") ,action: {
                                        context.delete(plantsModule.selectedModule)
                    
                                    }),secondaryButton: .cancel())
                                }
                                
                                
                                
                            }
                            Text("\(vm.selectedModule.needWatering) plants need watering today")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "606C38"))
                            ScrollView(.horizontal,showsIndicators: false){
                                if !plantsModule.selectedModule.wateredLocations.isEmpty {
                                    
                                    HStack(spacing: 20){
                                        
                                        ForEach(vm.filteredPlants,id: \.key.id) { location , value  in
                                            
                                            
                                            VStack{
                                                Text("\(location.id)")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color(hex: "606C38"))
                                                Text("\(value.filter({$0.prepared == false && $0.waterDate.isToday()}).count)")
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
                    
                }.onAppear {
                    vm.updatePlants(with: plantsModule.selectedModule)
                }
                
            
            
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
          
            return selectedModule.wateredLocations.filter({$0.value.filter({$0.prepared == false && $0.waterDate.isToday()}).count > 0})
            
        }
        
      
    }
}
#Preview {
    PlantsModuleCell(vm: PlantsModuleCell.ViewModel())
        .modelContainer(for:PlantsModuleDataClass.self)
        .environmentObject(PlantsModuleHomeView.ViewModel())
}
