//
//  ModuleListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import SwiftUI
import SwiftData

struct ModuleListView: View {
    @AppStorage("IsFirstTimeModuleListViewOpen") var isFirstTimeOpeningModuleView: Bool = true
    @Environment(\.dismiss) var dismiss
    @Binding var isAddingModuleOpen: Bool
    @Environment(\.modelContext) var context
    @Query(sort:\CreatingModuleData.name,order: .forward) var availableModules: [CreatingModuleData]
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
       
            GeometryReader { GeometryProxy in
                
                    
                    ScrollView{
                        ForEach(availableModules){ module in
                            VStack{
                                ModuleViewCell(module: module)
                                    .padding(6)
                                    .onTapGesture {
                                        isAddingModuleOpen.toggle()
                                        vm.selectedModule = module
                                        vm.showAlert.toggle()
                                    }.frame(height: 170)
                                    .alert(isPresented: $vm.showAlert) {
                                        Alert(title: Text("Add module ?"), message: Text("This will add module to your home screen."), primaryButton: .default(Text("Confirm"), action: {
                                            vm.addModuleToHome(context: context)
                                            dismiss()
                                            
                                        }), secondaryButton: .cancel())
                                    }
                                
                                
                            }
                            
                            
                        }.onAppear {
                            if isFirstTimeOpeningModuleView {
                                for module in DefaultModules.defaults {
                                    context.insert(module)
                                }
                                isFirstTimeOpeningModuleView = false
                            }
                        }
                }
            
            
        }
    }
}

extension ModuleListView{
    class ViewModel:ObservableObject {
        @Published var selectedModule: CreatingModuleData = CreatingModuleData(name: "", colorName: "", secondaryColorName: "")
        @Published var showAlert:Bool = false
        @AppStorage("isPackingModuleCreated") var isPackingModuleCreated = false
        @AppStorage("isPlantsModuleCreated") var isPlantsModuleCreated = false
        
        func addModuleToHome(context:ModelContext){
            switch selectedModule.name {
            case "Packing":
                let PackingModule = PackingModuleDataClass(name: "Packing")
                context.insert(PackingModule)
                context.delete(DefaultModules.packing)
                isPackingModuleCreated = true
            case "Plants":
                let PlantsModule = PlantsModuleDataClass()
                context.insert(PlantsModule)
                context.delete(DefaultModules.plants)
                isPlantsModuleCreated = true 
            default:
                return}
        }
                
                
    }
}




#Preview {
    ModuleListView(isAddingModuleOpen: .constant(false))
        .modelContainer(for:CreatingModuleData.self)
}
