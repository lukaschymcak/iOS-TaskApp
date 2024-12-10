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
    @AppStorage("isPlantsModuleCreated") var isPlantsModuleCreated = false
    @State private var cardOffset = CGSize.zero

    
    @Environment(\.modelContext) var context
    var body: some View {
        
                
                
                
        VStack {
            ZStack(alignment: .trailing) {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.lightCream)
                        .stroke(.darkGreen,lineWidth: 7)
                        .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight:
                                vm.selectedModule.needWatering == 0  ? 150 : 180)
                    
                    VStack{
                        VStack(alignment: .leading,spacing: 15) {
                            HStack {
                                Text(plantsVM.selectedModule.getName())
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.darkGreen)
                                Spacer()
                                Button {
                                    vm.showAlert.toggle()
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.darkGreen)
                                }.alert(isPresented: $vm.showAlert){
                                    Alert(title: Text("Remove module ?") ,message: Text("This will delete all your plants"),primaryButton: .destructive(Text("Confirm") ,action: {
                                        isPlantsModuleCreated = false
                                        context.delete(plantsVM.selectedModule)
                        
                                        
                                    }),secondaryButton: .cancel())
                                }
                                
                                
                                
                            }
                            Text("\(vm.selectedModule.needWatering) plants need watering today")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.darkGreen)
                            ScrollView(.horizontal,showsIndicators: false){
                                if !plantsVM.selectedModule.wateredLocations.isEmpty {
                                    
                                    HStack(spacing: 20){
                                        
                                        ForEach(vm.filteredPlants,id: \.key.id) { location , value  in
                                            
                                            
                                            VStack{
                                                Text("\(location.id)")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.darkGreen)
                                                Text("\(value.filter({$0.prepared == false && $0.waterDate.isToday()}).count)")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.darkGreen)
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                }
                            }
                            
                            
                        }.padding(.horizontal,8)
                            .frame(maxWidth: UIScreen.main.bounds.width - 55)
                        
                        
                        
                    }
                       
                    
                } .frame(maxWidth: .infinity)
                
                .onAppear {
                    vm.updatePlants(with: plantsVM.selectedModule)
                    if !swipeToDelete {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                cardOffset.width += -170
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                cardOffset.width = 0
                                swipeToDelete.toggle()
                            }
                        }
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                } .dragToDelete(cardOffset: $cardOffset) {
                    context.delete(plantsVM.selectedModule)
      
                }
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
                    .deleteCardSlow(cardOffset: $cardOffset, customHeight: plantsVM.selectedModule.plants.isEmpty ? 150 : 180)
            }.frame(maxWidth: .infinity)
            if !swipeToDelete {
                Button {
                    withAnimation {
                        swipeToDelete.toggle()
                        cardOffset.width = 0
                    }
                 
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .opacity(0.2)
                        .frame(maxWidth: UIScreen.main.bounds.width - 25)
                        .frame(height: 100)
                       
                        .overlay {
                            Text("You can drag to delete most of the items")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                }

              
            }
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
          
            return selectedModule.wateredLocations.filter({$0.value.filter({$0.watered == false && $0.waterDate.isToday()}).count > 0})
            
        }
        
      
    }
}
#Preview {
    PlantsModuleCell(vm: PlantsModuleCell.ViewModel())
        .modelContainer(for:PlantsModuleDataClass.self)
        .environmentObject(PlantsModuleViewModel())
}
