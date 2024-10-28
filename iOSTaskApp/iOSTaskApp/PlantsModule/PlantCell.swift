//
//  PlantCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantCell: View {
    @State var plantCell : PlantModel
    @State var color: Color = .red
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(color,lineWidth: 7)
                
       
                
                HStack {
                    VStack(alignment:.leading){
                        HStack(spacing:1) {
                            Image(systemName: "cat.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(color)
                                .padding()
                            VStack(spacing:10) {
                                Text(plantCell.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(color)
                                    .lineLimit(2)
                                 
                                Text("\(plantCell.water.description)ml")
                                    .fontWeight(.bold)
                                    .foregroundStyle(color)
                                
                            }
                            Spacer()
                            Button {
                                plantCell.toggleWatered()
                            } label: {
                                Image(systemName: plantCell.watered ? "checkmark.circle" : "drop.circle")
                                    .font(.system(size: 50))
                                    .foregroundStyle(color)
                            }.padding()

                        }.frame(maxWidth: .infinity,alignment: .leading)
              
                    }
              
                }
              
            }.frame(width: GeometryProxy.size.width - 55)
                .frame(height: 120)
                .frame(maxWidth: .infinity,alignment: .center)
                
        }
       
    }
}

#Preview {
    PlantCell(plantCell: MockPlants.plantA)
}
