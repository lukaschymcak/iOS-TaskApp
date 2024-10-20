//
//  CustomNavBarModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct CustomNavBarModule: View {
    @Environment(\.dismiss) var dismiss
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
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                }

                Text("\(name)")
                    .font(.system(size: 30))
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
               

                
                    
            }.frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,20)
                
                Spacer()
            

            
            }
        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
            Spacer()
        }
    }


#Preview {
    CustomNavBarModule(module: "Packing", name: "Packing")
}
