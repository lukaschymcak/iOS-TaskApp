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
    var module: String
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
        ZStack {
            Color(hex: "22577A")
                .ignoresSafeArea()
            NavigationStack {
                HStack {
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

                    
                }

                Text("\(name)")
                    .font(.system(size: 30))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
                
               

                

                    Spacer()
                    Image("leaves")
                        .resizable()
                        .frame(width: 50, height: 50)
                }.background(Color(hex: "22577A"))
                
            }
                .frame(height: 50)
        }
    @ViewBuilder
    var plantsNavbar: some View {
        NavigationStack {
            HStack(alignment: .bottom) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")

                        .font(.largeTitle)
                        .foregroundStyle(Color(hex: "FEFAE0"))
                        .fontWeight(.bold)
                }

                Text("\(name)")
                    .font(.system(size: 30))
                    .foregroundStyle(Color(hex: "FEFAE0"))
                    .fontWeight(.bold)
                Spacer()

            }.padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

        }
        .frame(height: 50)
        Spacer()
    }

    }

  



#Preview {
    CustomNavBarModule(module: "Packing", name: "Plants")

}
