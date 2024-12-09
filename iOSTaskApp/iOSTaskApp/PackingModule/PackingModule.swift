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
                        .frame(maxWidth: UIScreen.main.bounds.width - 25,maxHeight: packingModule.trips.isEmpty ? 150 : 180)
                    
                    VStack(spacing: 10){
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(packingModule.name)
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
                                        isPackingModuleCreated = false
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
                                    if let earliestTrip = packingModule.earliestTrip {
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
                        .frame(maxWidth: UIScreen.main.bounds.width - 55)
                        
                        
                        
                    }.padding(.vertical,20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }.dragToDelete(cardOffset: $cardOffset) {
                    isPackingModuleCreated = false
                    context.delete(packingModule)
                    context.insert(DefaultModules.packing)
                    
                }
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
                    .deleteCardSlow(cardOffset: $cardOffset, customHeight: packingModule.trips.isEmpty ? 150 : 180)
            }.onAppear {
             
                if !swipeToDelete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            cardOffset.width += -170
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            cardOffset.width = 0
                            swipeToDelete.toggle()
                        }
                    }
                    
                        
                    
                    
                  
                    
                    
                }
                
                
            }
            if !swipeToDelete {
                Button {
                    withAnimation {
                        swipeToDelete.toggle()
                        cardOffset.width = 0
                    }
                 
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .opacity(0.2)
                        .frame(maxWidth: UIScreen.main.bounds.width - 25)
                        .frame(height: 100)
                       
                        .overlay {
                            Text("You can drag to delete most of the items")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                }

              
            }
     
        }.frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom,5)
            
    }
    }




#Preview {
    PackingModule(packingModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
