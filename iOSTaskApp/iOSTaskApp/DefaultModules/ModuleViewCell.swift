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
        VStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 20)
                .stroke(module.color,lineWidth: 6)
                .frame(width: 160, height: 150)
                .overlay {
                    Text("\(module.name) module")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundStyle(module.color)
                        .multilineTextAlignment(.leading)
                    Button {
                        context.delete(module)
                    } label: {
                        Image(systemName: "minus")
                    }

                       
                }
             
            
        }
        .padding(.bottom,10)
    }
}

#Preview {
    ModuleViewCell(module: DefaultModules.packing)
        .modelContainer(for:CreatingModuleData.self)
}
