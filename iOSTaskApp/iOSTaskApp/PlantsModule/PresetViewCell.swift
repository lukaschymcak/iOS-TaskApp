//
//  PresetViewCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PresetViewCell: View {
    var plantCell:PlantModel
    var body: some View {
        ZStack{
            GeometryReader { GeometryProxy in
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.green,lineWidth: 5)
                    .fill(.clear)
                    .frame(width: GeometryProxy.size.width - 50, height: 100)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .overlay {
                        HStack(spacing:30){
                            Image(systemName: plantCell.image)
                                .font(.system(size: 50))
                                .foregroundStyle(.green)
                            Text(plantCell.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            Spacer()
                        }   .frame(width: GeometryProxy.size.width - 100)
                     
                    }
            }
           
                
        }.frame(height: 100)
    }
}

#Preview {
    PresetViewCell(plantCell: DefaultPlants.monstera)
}
