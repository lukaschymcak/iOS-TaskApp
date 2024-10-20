//
//  PackingModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 11/10/2024.
//

import SwiftUI



struct PackingModule: View {
    @Environment(\.colorScheme) var colorScheme
    let packingModule: PackingModuleDataClass
  
    var textColor : Color {
        colorScheme == .dark ? .white : .black
    }
    var body: some View {
       
        VStack(alignment: .leading){
            Text(packingModule.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Utils.textColor(colorScheme))
            ZStack{
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                    .stroke(packingModule.color,lineWidth: 7)
                    .frame(maxWidth: UIScreen.main.bounds.width - 15,maxHeight: 150)
                HStack{
                    VStack(alignment:.leading){
                        Text("NEXT TRIP:")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .underline()
                            .foregroundStyle(packingModule.color)
                            .padding(.bottom,1)
                        Spacer()
                        
                        VStack(alignment:.leading){
                            Text("\(packingModule.earliestTripName)")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(packingModule.color)
                            Text("in \(packingModule.inDays) days")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(packingModule.color)
                        }
                        Spacer()
                        
                    }
                    .frame(height: 120)
                    
                    
                    
                    
                    Spacer()
                    HStack{
                        VStack(alignment:.trailing){
                            Spacer()
                            
                            HStack {
                                Text("\(packingModule.percentage)")
                                    .font(.system(size: 40))
                                    .foregroundStyle(packingModule.color)
                                    .fontWeight(.bold)
                                Image(systemName: "percent")
                                    .foregroundStyle(packingModule.color)
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
    
}



#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
}
