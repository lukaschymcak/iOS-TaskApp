//
//  CustomNavBar.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 15/10/2024.
//

import SwiftUI

struct CustomNavBar: View {
    
    @State var shake: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Binding var isWelcomeScreenOver: Bool
    @Binding var name: String
    @Binding var isAddModuleOpen: Bool
    var body: some View {
        HStack{
            VStack{
                Button {
                  
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .font(.system(size: 25))
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .fontWeight(.bold)
                }
            
            }
            Spacer()
            Button {
          isWelcomeScreenOver.toggle()
                
            } label: {
                Text("hello, \n \(name)")
                    .font(.system(size: 20))
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .fontWeight(.bold)
            }.accessibilityIdentifier("welcomeScreenButton")
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
#Preview {
    CustomNavBar(isWelcomeScreenOver: .constant(false), name: .constant("Lukas"), isAddModuleOpen: .constant(false))
}



