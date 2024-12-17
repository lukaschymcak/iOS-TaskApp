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
    @State var showAlert:Bool = false
    @EnvironmentObject var dateManager: DateManager
    var packingModule: PackingModuleDataClass
    @AppStorage("swipreToDeleteInfo") var swipeToDelete: Bool = false
    @AppStorage("isPackingModuleCreated") var isPackingModuleCreated = false
    @State private var cardOffset = CGSize.zero
    var body: some View {
        
        
        VStack {
            ZStack(alignment: .trailing){
               
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "22577A"))
                        .stroke(.orange,lineWidth: 7)
                        .frame(maxWidth: UIScreen.main.bounds.width - 25)
                        .frame(height: packingModule.trips.count > 0 ? 210 : 150)
                    
                    VStack(spacing: 0){
                        
                 
                            HStack {
                                Image("suitcase")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding(.trailing,8)
                                Text(packingModule.name)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Spacer()
                               
       

                                
                                
                            } .padding(.horizontal,8)
                        
                            .padding(.bottom, packingModule.trips.count > 0 ? 10 : 5)
                            
                            
                      
                  
                        
                        
                        
                        
                        
                        HStack(alignment:.bottom){
                            VStack(alignment:.leading, spacing: 0){
                  
                           
                                
                                if packingModule.trips.isEmpty {
                                    Text("No upcoming trips")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                         
                                    
                                    
                                } else {
                                    if let earliestTrip = packingModule.earliestTrip {
                                        Text("upcoming trip:")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                        if  earliestTrip.name == "" {
                                            Text("Trip")
                                                .font(.system(size: 30))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        } else{
                                            Text(earliestTrip.name)
                                                .font(.system(size: 30))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                                .lineLimit(1)
                                        }
                                        
                                        if Calendar.current.isDate(earliestTrip.dateFrom, inSameDayAs: Date.now){
                                            Text("Today")
                                                .font(.system(size: 30))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        } else{
                                            Text("in \(packingModule.dayDifference) days")
                                                .font(.system(size: 30))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                            }
                            Spacer()
                            if !packingModule.trips.isEmpty{
                                Text("\(packingModule.percentage)% \n packed")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.trailing)
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        .padding(.horizontal,8)
           
                        
                        
                        
                    }          .frame(maxWidth: UIScreen.main.bounds.width - 55)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
           
     
        }.frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom,10)
            
    }
    }




#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
