//
//  ModuleHomeViewList.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/11/2024.
//

import SwiftUI

struct ModuleHomeViewList: View {
    
    var body: some View {
          ScrollView {
            PackageModuleHomeView()
            PlantsModuleHomeView()
            
            
        }
    }
}

#Preview {
    ModuleHomeViewList()
}
