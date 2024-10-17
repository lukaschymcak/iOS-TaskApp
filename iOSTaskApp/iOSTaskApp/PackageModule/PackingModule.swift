//
//  PackingModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 11/10/2024.
//

import SwiftUI



struct PackingModule: View {
    @Environment(\.colorScheme) var colorScheme
    var IsDarkModel: Bool {
        colorScheme == .dark
    }
    var body: some View {
        if IsDarkModel {
            DarkPackingModule()
        } else {
            LightModeModule()
        }
       
            }
    }

struct DarkPackingModule:View{
    var mainColor : Color = .red
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
                .stroke(mainColor,lineWidth: 4)
                .frame(maxWidth: UIScreen.main.bounds.width - 15,maxHeight: 150)
            HStack{
                VStack(alignment:.leading){
                    Text("NEXT TRIP:")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .underline()
                        .foregroundStyle(mainColor)
                        .padding(.bottom,1)
                    Spacer()
            
                    VStack(alignment:.leading){
                        Text("Chata Levoca ")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(mainColor)
                        Text("in 10 days")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(mainColor)
                    }
                    Spacer()
                    
                }
                .frame(height: 120)
                
   
            
                
                Spacer()
                HStack{
                    VStack(alignment:.trailing){
                        Spacer()
                
                        HStack {
                            Text("70")
                                .font(.system(size: 40))
                                .foregroundStyle(mainColor)
                                .fontWeight(.bold)
                            Image(systemName: "percent")
                                .foregroundStyle(mainColor)
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                             
                        }
                        Spacer()
                    }
                    .frame(height: 110)
                    
                    
                }
         
            
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 45,maxHeight: 150)
     
        
        }
    }
}

struct LightModeModule:View {
    var mainColor:Color = .orange
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(mainColor,lineWidth: 4)
                .frame(maxWidth: UIScreen.main.bounds.width - 15,maxHeight: 150)
            HStack{
                VStack(alignment:.leading){
                    Text("NEXT TRIP:")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .underline()
                        .foregroundStyle(mainColor)
                        .padding(.bottom,1)
                    Spacer()
            
                    VStack(alignment:.leading){
                        Text("Chata Levoca ")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(mainColor)
                        Text("in 10 days")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(mainColor)
                    }
                    Spacer()
                    
                }
                .frame(height: 120)
                
   
            
                
                Spacer()
                HStack{
                    VStack(alignment:.trailing){
                        Spacer()
                
                        HStack {
                            Text("70")
                                .font(.system(size: 40))
                                .foregroundStyle(mainColor)
                                .fontWeight(.bold)
                            Image(systemName: "percent")
                                .foregroundStyle(mainColor)
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                             
                        }
                        Spacer()
                    }
                    .frame(height: 110)
                    
                    
                }
         
            
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 65,maxHeight: 150)
     
        
        }
    }
}


#Preview {
    PackingModule()
}
