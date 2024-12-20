//
//  PresetViewCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetViewCell: View {
    @Environment(\.colorScheme) var colorScheme
    var plantCell:PlantModel
    var body: some View {
        ZStack{
            GeometryReader { GeometryProxy in
                RoundedRectangle(cornerRadius: 20)
                    .fill(.lightGreen)
                    .frame(width: GeometryProxy.size.width - 50, height: 80)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .overlay {
                        HStack(spacing:20){
                            Image(plantCell.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .font(.title)
                                .foregroundStyle(.white)
                            Text(plantCell.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .frame(width: GeometryProxy.size.width - 70)
                    
                     
                    }
            }
           
                
        }.frame(height: 80)
    }
}

#Preview {
    PresetViewCell(plantCell: DefaultPlants.monstera)
}
