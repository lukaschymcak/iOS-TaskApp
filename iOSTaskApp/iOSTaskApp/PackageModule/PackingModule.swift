//
//  PackingModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 11/10/2024.
//

import SwiftUI
import SwiftData



struct PackingModule: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @State var packingModule: PackingModuleDataClass
    var textColor : Color {
        colorScheme == .dark ? .white : .black
    }
    var body: some View {
        
        
        ZStack{
           
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? packingModule.color.opacity(0.3) : .clear)
                .stroke(packingModule.color,lineWidth: 7)
                .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight: packingModule.trips.isEmpty ? 150 : 180)
               
            VStack(spacing: 10){
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(packingModule.name == "" ? "Packing" :
                                packingModule.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(packingModule.color)
                        Spacer()
                        Button {
                            context.delete(packingModule)
                            context.insert(DefaultModules.packing)
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(packingModule.color)
                        }
                        
                        
                    }
                  
                    
                }.padding(.horizontal,8)
       
                .frame(maxWidth: UIScreen.main.bounds.width - 55)
                    
                      
           
                
                      
                HStack(alignment:.bottom){
                    VStack(alignment:.leading,spacing: 5){
                                Text("next trip:")
                                    .font(.system(size: 23))
                                    .fontWeight(.bold)
                                    .foregroundStyle(packingModule.color)
                                    
                            if packingModule.trips.isEmpty {
                                Text("No trips")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundStyle(packingModule.color)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                        
                       
                 
                            } else {
                                if let firstTrip = packingModule.trips.first {
                                    if  firstTrip.name == "" {
                                        Text("Trip")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(packingModule.color)
                                    } else{
                                        Text(firstTrip.name)
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(packingModule.color)
                                            .lineLimit(1)
                                    }
                                    
                                    if firstTrip.dayDifference() == 0{
                                        Text("Today")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(packingModule.color)
                                    } else{
                                        Text("in \(firstTrip.dayDifference()) days")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(packingModule.color)
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                            Spacer()
                                    if !packingModule.trips.isEmpty{
                                        Text("\(packingModule.percentage)% \n packed")
                                            .font(.system(size: 30))
                                            .foregroundStyle(packingModule.color)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.trailing)
                                        
                                    }
                                  
                                    
                             
       
                    
                    
                }
                .padding(.horizontal,8)
                .frame(maxWidth: UIScreen.main.bounds.width - 55)
                
                
                
            }.padding(.vertical,20)
        }
    }
    }




#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
