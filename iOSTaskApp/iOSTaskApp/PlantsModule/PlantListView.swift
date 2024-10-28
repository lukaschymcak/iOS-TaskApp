//
//  PlantListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantListView: View {
    var plantsModule: PlantsModuleDataClass
    var location: houseLocation
    var body: some View {
        ForEach(plantsModule.filterByLocation(a: location)){ plant in
            PlantCell(plantCell: plant,color: plantsModule.color)
        }
    }
}

#Preview {
    PlantListView(plantsModule: MockPlantsModule.moduleA,location: .bathroom)
}
