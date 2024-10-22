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
    @State var selectedModule: CreatingModuleData = CreatingModuleData(name: "", colorName: "")
    let collums: [GridItem] = [
        GridItem(.fixed(100),spacing: 85,alignment: nil),
        GridItem(.fixed(100),spacing: 85,alignment: nil),
    ]
   
    var body: some View {
        
        LazyVGrid(columns: collums){
            ForEach(availableModules){ module in
                
                ModuleViewCell(module: module)
                    .padding(6)
                    .onTapGesture {
                        isAddingModuleOpen.toggle()
                        selectedModule = module
                    }
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



#Preview {
    ModuleListView(isAddingModuleOpen: .constant(false), selectedModule: DefaultModules.gymTracker)
        .modelContainer(for:CreatingModuleData.self)
}
