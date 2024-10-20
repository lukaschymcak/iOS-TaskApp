//
//  AddingModuleView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 16/10/2024.
//

import SwiftUI

struct AddingModuleView: View {
    var module:CreatingModuleData
    @Bindable var packageModule: PackingModuleDataClass
    @Environment(\.modelContext) var context
    @State var tapped:Bool = false
    @State var selection:Color = .red
    var colors:[Color] = [.red,.green,.yellow,.orange]
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                VStack(alignment: .center){
                    Text("Swipe Up For Details")
                        .font(.subheadline)
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .padding(.top,10)
                 
                    Text("\(module.name) \n Module")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,minHeight: 90,alignment: .center)
               
             
                }.padding(.vertical,2)
          
            
                
                
                VStack {
                    HStack{
                        Text("Colors")
                            .font(.title)
                            .fontWeight(.bold)
                    
                        
                    }
                    .padding(.horizontal, 20)
                    HStack{
                      
                            ForEach(colors,id:\.self){ color in
                                Button {
                                    packageModule.colorName = color.description
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(color)
                                        .frame(width: 40, height: 40)
                                        
                                }.padding(.horizontal,10)
                                    .padding(.bottom,10)

                            }
                            
                    
                    }.padding(.bottom,10)
                    HStack{
                        Text("Name:")
                            .font(.title)
                            .fontWeight(.bold)
                        TextField("", text: $packageModule.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding()
                            .background(.gray)
                            .clipShape(.rect(cornerRadius: 15))
                        Button {
                            context.insert(module)
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 80,height: 55)
                                .overlay {
                                    Text("Add")
                                        .foregroundStyle(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                        }

                            
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom,10)
                    
                    Text("Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("ASDAS KDAS KKKASKDASD KKSAD ASD  KSAKDASKD KKSAD KASD ")
                        .lineLimit(nil)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
            }
            
        }
        .presentationDetents([.height(350),.height(550)])
    }
}

#Preview {
    AddingModuleView(module: DefaultModules.packing, packageModule: PackingMockData.packingMock)
        .modelContainer(for: PackingModuleDataClass.self)
}
