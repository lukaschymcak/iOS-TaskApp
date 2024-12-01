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
    @AppStorage("userName") var name:String = ""
    @Binding var isAddModuleOpen: Bool
    @EnvironmentObject var packingVM: PackingModuleViewModel
    
    var body: some View {
        GeometryReader { GeometryProxy in
            HStack{
                VStack{
                    NavigationLink {
                        SettingsView()
                            .environmentObject(packingVM)
                        
                        
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                            .foregroundStyle(Utils.textColor(colorScheme))
                            .fontWeight(.bold)
                    }

                  
                    
                }
                Button {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                } label: {
                    Image(systemName: "bell.slash")
                        
                }

                Spacer()
                Button {
                    isWelcomeScreenOver.toggle()
                    
                } label: {
                    Text("hello, \n \(name)")
                        .font(.title3)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .fontWeight(.bold)
                }.accessibilityIdentifier("welcomeScreenButton")
                Spacer()
                Button {
                    isAddModuleOpen.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .fontWeight(.bold)
                    
                    
                    
                }
                
                
                
            }  .frame(width: GeometryProxy.size.width - 30)
                .frame(maxWidth: .infinity, alignment: .center)
            
        }.frame(height: 70)
        }
}
#Preview {
    CustomNavBar(isWelcomeScreenOver: .constant(false), name: "Lukas", isAddModuleOpen: .constant(false))
}



