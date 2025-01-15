//
//  RecipeModuleView.swift
//  TaskApp
//
//  Created by Lukas Chymcak on 15/01/2025.
//

import SwiftUI

struct ShoppingModuleView: View {
    var body: some View {
        
        
        
        VStack {
            ZStack(alignment: .trailing){
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(hex: "F5AB54"))
                    
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .frame(height: 190 )
                    VStack(spacing:25){
                        
                        
                        HStack {
                            Image("shopping")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing,8)
                            Text("Shopping")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            
                            
                            
                            
                            
                        } .padding(.horizontal,8)
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        HStack(alignment:.bottom){
                            VStack(alignment:.leading, spacing: 5){
                                
                                
                                
                                
                                
                                Text("No shopping planned ")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                         
                         
                                
                                
                            }
                            
     
      
                            
                            Spacer()
                            
                            
                            
                            
                            
                            
                        }
                        .padding(.horizontal,8)
                        
                        
                        
                        
                        
                    }          .frame(width: max(UIScreen.main.bounds.width - 55,0))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
        }.overlay(content: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.3))
            
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: 190 )
            Text("Work in Progress")
                .font(.title)
                .fontWeight(.bold)
                
                
        })
        
        
        .frame(maxWidth: .infinity, alignment: .center)


        
        
    }
}


#Preview {
    ShoppingModuleView()
}
