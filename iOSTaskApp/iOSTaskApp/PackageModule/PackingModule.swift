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
    @State var packingModule: PackingModuleDataClass
    var textColor : Color {
        colorScheme == .dark ? .white : .black
    }
    var body: some View {
        
        
        ZStack{
           
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "22577A"))
                .stroke(.orange,lineWidth: 7)
                .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight: packingModule.trips.isEmpty ? 150 : 180)
               
            VStack(spacing: 10){
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(packingModule.name == "" ? "Packing" :
                                packingModule.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        Spacer()
                        Button {
                            showAlert.toggle()
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }.alert(isPresented: $showAlert){
                            Alert(title: Text("Remove module ?") ,message: Text("This will delete all your trips , and your trip history."),primaryButton: .destructive(Text("Confirm") ,action: {
                                context.delete(packingModule)
                                context.insert(DefaultModules.packing)
                            }),secondaryButton: .cancel())
                        }
                        
                        
                    }
                  
                    
                }.padding(.horizontal,8)
       
                .frame(maxWidth: UIScreen.main.bounds.width - 55)
                    
                      
           
                
                      
                HStack(alignment:.bottom){
                    VStack(alignment:.leading,spacing: 5){
                                Text("next trip:")
                                    .font(.system(size: 23))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    
                            if packingModule.trips.isEmpty {
                                Text("No trips")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                        
                       
                 
                            } else {
                                if let firstTrip = packingModule.trips.first {
                                    if  firstTrip.name == "" {
                                        Text("Trip")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    } else{
                                        Text(firstTrip.name)
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                    }
                                    
                                    if Calendar.current.isDate(firstTrip.dateTo, inSameDayAs: Date.now){
                                        Text("Today")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    } else{
                                        Text("in \(firstTrip.dayDifference()) \(firstTrip.dayDifference() == 1 ? "day": "days")")
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
                .frame(maxWidth: UIScreen.main.bounds.width - 55)
                
                
                
            }.padding(.vertical,20)
        }.onAppear {
            packingModule.sortTrips()
        }
    }
    }




#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
