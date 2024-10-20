//
//  ModuleListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import SwiftUI

struct ModuleListView: View {
    @Binding var isAddingModuleOpen: Bool
    @Environment(\.colorScheme) var colorScheme
    let modules: [CreatingModuleData]
    @State var selectedModule: CreatingModuleData = CreatingModuleData(name: "", colorName: "")
    let collums: [GridItem] = [
        GridItem(.fixed(100),spacing: 85,alignment: nil),
        GridItem(.fixed(100),spacing: 85,alignment: nil),
    ]
    var body: some View {
        LazyVGrid(columns: collums){
        ForEach(modules){ module in
            
            ModuleViewCell(module: module)
                .padding(6)
                .onTapGesture {
                 
                    isAddingModuleOpen.toggle()
                    selectedModule = module
                }
                .onAppear(perform: {
                  
                })
                .sheet(isPresented: $isAddingModuleOpen) {
                    AddingModuleView(module: selectedModule,packageModule: PackingMockData.packingMock)
                }
                
        }
       
      
        }
    }
}



#Preview {
    ModuleListView(isAddingModuleOpen: .constant(false),modules: DefaultModules.defaults, selectedModule: DefaultModules.gymTracker)
}
