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
    let packingModule: PackingModuleDataClass
    @Query var trips: [Trip]
    var textColor : Color {
        colorScheme == .dark ? .white : .black
    }
    var body: some View {
       
        VStack(alignment: .center,spacing: 10){
            HStack {
                Text(packingModule.name == "" ? "Packing" :
                packingModule.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(textColor)
                Spacer()
                Button {
                    context.delete(packingModule)
                    context.insert(DefaultModules.packing)
                    for trip in trips {
                        context.delete(trip)
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(textColor)
                }

                
            }.frame(maxWidth: UIScreen.main.bounds.width - 50,alignment: .center)
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.systemBackground))
                    .stroke(packingModule.color,lineWidth: 7)
                    .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight: 150)
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
                            if trips.isEmpty {
                                Text("No Trips \n added")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundStyle(packingModule.color)
                                    .multilineTextAlignment(.leading)
                            } else {
                                if trips.first?.name == "" {
                                    Text("Trip")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .foregroundStyle(packingModule.color)
                                } else{
                                    Text(trips.first?.name ?? "")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .foregroundStyle(packingModule.color)
                                }
                             
                                if trips.first?.dayDifference() == 0{
                                    Text("Today")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .foregroundStyle(packingModule.color)
                                } else{
                                    Text("in \(trips.first?.dayDifference() ?? 0) days")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .foregroundStyle(packingModule.color)
                                }
                            }
                            
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
                .padding(8)
                .frame(maxWidth: UIScreen.main.bounds.width - 55,maxHeight: 150)
               
                
                
            }
        }
    }
    
}



#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
