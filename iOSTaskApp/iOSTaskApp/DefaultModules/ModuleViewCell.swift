//
//  ModuleViewCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 20/10/2024.
//

import SwiftUI

struct ModuleViewCell: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    let module:CreatingModuleData
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 20)
                    .stroke(module.secondaryColor,lineWidth: 12)
                    .fill(module.color)
                
                    .frame( width: GeometryProxy.size.width - 30 ,height: 150)
                
                    .overlay {
                        HStack {
                            VStack(alignment:.leading) {
                                Text("\(module.name)")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundStyle(module.name == "Plants" ? module.secondaryColor : .white)
                                    .multilineTextAlignment(.leading)
                                Text("module")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundStyle(module.name == "Plants" ? module.secondaryColor : .white)
                                    .multilineTextAlignment(.leading)

                            }.padding()
                                .background(RoundedRectangle(cornerRadius: 15).stroke(module.secondaryColor,lineWidth: 11).fill(module.color).frame(maxWidth: .infinity))
                            Spacer()
                                Text(module.desc)
                                .fontWeight(.bold)
                                .foregroundStyle(module.name == "Plants" ? module.secondaryColor : .white)
                        }.frame(width: GeometryProxy.size.width - 50)
                       
              
                        

                           
                    }
                 
                
            }
                .frame(maxWidth: .infinity,alignment: .center)
         
        }
        
    }
}

#Preview {
    ModuleViewCell(module: DefaultModules.plants)
       
}
