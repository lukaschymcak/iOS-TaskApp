//
//  ModuleListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import SwiftUI
import SwiftData

struct ModuleListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isAddingModuleOpen: Bool
    @Environment(\.modelContext) var context
    @Query(sort:\CreatingModuleData.name,order: .forward) var availableModules: [CreatingModuleData]
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
       
            GeometryReader { GeometryProxy in
                
                    
                    ScrollView{
                        ForEach(DefaultModules.defaults){ module in
                            VStack{
                                ModuleViewCell(module: module)
                                    .padding(6)
                                    .onTapGesture {
                                        vm.selectedModule = module
                                        vm.showAlert.toggle()
                                    }.frame(height: 170)
                                    .alert("Add Module ?", isPresented: $vm.showAlert, actions: {
                                        Button("Confirm") {
                                            if vm.addModuleToHome(context: context) {
                                                dismiss()
                                                }
                                         
                                            
                                        }
                                        Button("Cancel", role: .cancel) {
                                        }

                                    } ,message: {
                                        Text("This will add module to your home screen.")
                                    }
                                    ).alert("Module Already Exists", isPresented: $vm.moduleAlreadyExists) {
                                        Button("Ok") {
                                        }
                                    }
                                
                                
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
        @Published var moduleAlreadyExists:Bool = false
        @AppStorage("isPackingModuleCreated") var isPackingModuleCreated = false
        @AppStorage("isPlantsModuleCreated") var isPlantsModuleCreated = false
        
        func addModuleToHome(context:ModelContext) -> Bool {
            switch selectedModule.name {
            case "Packing":
                let PackingModule = PackingModuleDataClass(name: "Packing")
                if isPackingModuleCreated {
                    moduleAlreadyExists.toggle()
               return false
                }
                context.insert(PackingModule)
                isPackingModuleCreated = true
                return true
            case "Plants":
                let PlantsModule = PlantsModuleDataClass()
                if isPlantsModuleCreated {
                    moduleAlreadyExists.toggle()
                    return false
                }
                context.insert(PlantsModule)
                isPlantsModuleCreated = true
                return true
            default:
                return false }
     
        }
                
                
    }
}




#Preview {
    ModuleListView(isAddingModuleOpen: .constant(false))
        .modelContainer(for:CreatingModuleData.self)
}
