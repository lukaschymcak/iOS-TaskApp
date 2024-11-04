//
//  PresetPlantsListView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetPlantsListView: View {

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(DefaultPlants.presetPlants) { plant in
                        NavigationLink {
                            Text(plant.name)
                        } label: {
                            PresetViewCell(plantCell: plant)
                        }

                    }
                }.padding(.top, 20)
            }
        }
    }
}

#Preview {
    PresetPlantsListView()
}
