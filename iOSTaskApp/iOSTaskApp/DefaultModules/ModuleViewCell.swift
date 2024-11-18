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
                    .stroke(module.color,lineWidth: 6)
                    .frame( width: GeometryProxy.size.width - 30 ,height: 150)
                
                    .overlay {
                        HStack {
                            VStack(alignment:.leading) {
                                Text("\(module.name)")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundStyle(module.color)
                                    .multilineTextAlignment(.leading)
                                Text("module")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundStyle(module.color)
                                    .multilineTextAlignment(.leading)

                            }.padding()
                                .background(RoundedRectangle(cornerRadius: 20).stroke(module.color,lineWidth: 6).fill(module.color.opacity(0.1)))
                                Text(module.desc)
                                .fontWeight(.bold)
                                .foregroundStyle(module.color)
                        }.frame(width: GeometryProxy.size.width - 50)
              
                        

                           
                    }
                 
                
            }
                .frame(maxWidth: .infinity,alignment: .center)
         
        }
        
    }
}

#Preview {
    ModuleViewCell(module: DefaultModules.packing)
        .modelContainer(for:CreatingModuleData.self)
}
