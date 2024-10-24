//
//  ModuleListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import SwiftUI
import SwiftData

struct ModuleListView: View {
    @Binding var isAddingModuleOpen: Bool
    @Environment(\.modelContext) var context
    @Query(sort:\CreatingModuleData.name,order: .forward) var availableModules: [CreatingModuleData]
    @Query var module : [PackingModuleDataClass]
    @State var selectedModule: CreatingModuleData = CreatingModuleData(name: "", colorName: "")
  
    
    var body: some View {
       
            GeometryReader { GeometryProxy in
                
                    
                    ScrollView{
                    ForEach(availableModules){ module in
                        VStack{
                        ModuleViewCell(module: module)
                            .padding(6)
                            .onTapGesture {
                                isAddingModuleOpen.toggle()
                                selectedModule = module
                            }.frame(height: 170)
                            .sheet(isPresented: $isAddingModuleOpen) {
                                AddingModuleView(module: selectedModule)
                            }
                        
                        
                    }
                    
                    
                }.onAppear {
                    if availableModules.isEmpty {
                        for module in DefaultModules.defaults {
                            context.insert(module)
                        }
                        
                        
                        
                    }
                    
                }
                }
            
            
        }
    }
}




#Preview {
    ModuleListView(isAddingModuleOpen: .constant(false), selectedModule: DefaultModules.gymTracker)
        .modelContainer(for:CreatingModuleData.self)
}
