//
//  CustomNavBarModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct CustomNavBarModule: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var module:String
    var name: String
   
    var body: some View {
        switch module {
        case "Packing":
            packingNavBar
        default:
            Text("hello")
        }
      
        
     
        }
    
    @ViewBuilder
    var packingNavBar: some View {
        NavigationStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30))
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .fontWeight(.bold)
                }

                Text("\(name)")
                    .font(.system(size: 30))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
                
               

                
                    
            }.padding(.top,5)
            .frame(maxWidth: .infinity,alignment: .leading)
                
                
                Spacer()
            

            
            }
        .frame(height: 50)
            Spacer()
        }
    }


#Preview {
    CustomNavBarModule(module: "Packing", name: "Packing")
}
