//
//  CustomNavBar.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 15/10/2024.
//

import SwiftUI

struct CustomNavBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isWelcomeScreenOver: Bool
    @Binding var name: String
    @Binding var isAddModuleOpen: Bool
    var body: some View {
        HStack{
            Button {
                isAddModuleOpen.toggle()
            } label: {
                Image(systemName: "slider.vertical.3")
                    .font(.system(size: 25))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
            }

            
            Spacer()
            Button {
       isWelcomeScreenOver.toggle()
                
            } label: {
                Text("hello, \n \(name)")
                    .font(.system(size: 20))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
            }
            Spacer()
            Button {
                isAddModuleOpen.toggle()
                
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
            }

        
        }
     
        
        }
}



