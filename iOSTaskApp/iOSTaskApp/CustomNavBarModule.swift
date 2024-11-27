//
//  CustomNavBarModule.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 17/10/2024.
//

import SwiftUI

struct CustomNavBarModule: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
   
    var module: String
    var name: String
    var addPlant: () -> Void 
    var body: some View {
        switch module {
        case "Packing":
            packingNavBar
        case "Plants":
            plantsNavbar
        default:
            Text("hello")
        }

    }

    @ViewBuilder
    var packingNavBar: some View {
        GeometryReader { GeometryProxy in
            HStack {
     
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                            .fontWeight(.bold)
                    }
                    
             
                
                
                
                
                
                Text(name)
                    .font(.title)
                    .foregroundStyle(Color(hex: "FEFAE0"))
                    .fontWeight(.bold)
                
                Spacer()
               
                
                
                
            }
            .frame(width: GeometryProxy.size.width - 30)
                .frame(maxWidth: .infinity, alignment: .center)
            .background(Color(hex: "22577A"))
        }
              
    
               

                
                    
            
                
                

            

            
            
  
        }
    @ViewBuilder
    var plantsNavbar: some View {
        GeometryReader { GeometryProxy in
 
                //            HStack(alignment:.bottom){
                //                Button {
                //                    dismiss()
                //                } label: {
                //                    Image(systemName: "chevron.left")
                //
                //                        .font(.largeTitle)
                //                        .foregroundStyle(Color(hex: "FEFAE0"))
                //                        .fontWeight(.bold)
                //                }
                //
                //                Text("\(name)")
                //                    .font(.system(size: 30))
                //                    .foregroundStyle(Color(hex: "FEFAE0"))
                //                    .fontWeight(.bold)
                //                Spacer()
                //
                //
                //
                //
                //
                //                }
                HStack{
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundStyle(Color(hex: "FEFAE0"))
                            .fontWeight(.bold)
                    }
                    
                    
                    
                    
                    
                    
                    
                    Text(name)
                        .font(.title)
                        .foregroundStyle(Color(hex: "FEFAE0"))
                        .fontWeight(.bold)
        
           
                    Spacer()
                    
                    Button {
                        addPlant()
                        
                    } label: {
                        ZStack {
                            Image("pot")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    Color(hex: "EFD0CA")
                                )
                                .offset(x: -1, y: 0)
                        }
                        
                        
                    }
                    
                    
                    
                }.frame(width: GeometryProxy.size.width - 30)
                .frame(maxWidth: .infinity, alignment: .center)

                
            
            
        }.frame(height: 70)
        }

    }

  




#Preview {

    CustomNavBarModule(module: "Packing", name: "Packing") {
        
    }

}
