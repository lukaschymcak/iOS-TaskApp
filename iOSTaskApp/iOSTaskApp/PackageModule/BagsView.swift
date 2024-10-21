//
//  BagsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 21/10/2024.
//

import SwiftUI

struct BagsView: View {
    var color: Color = .orange
    @State var addingBag:Bool = true
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack {
                VStack(alignment: .center){
                    CustomNavBarModule(module: "Packing", name: "Trip")
                        .padding(.top,30)
                        .frame(width: GeometryProxy.size.width - 30,height: 25)
                    color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                }.frame(maxWidth: .infinity)
            
            HStack {
                Text("MY BAGS:")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .frame(width: GeometryProxy.size.width - 80,alignment: .leading)
                Button {
                    addingBag.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .frame(maxWidth: .infinity)
        }
            .sheet(isPresented: $addingBag) {
                AddingBagView()
                    .presentationDetents([.height(550)])
            }
        }
    
     
    }
}


struct AddingBagView:View {
    @State var name:String = ""
    var body: some View {
        VStack{
            HStack{
                Text("Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                TextField("Enter Name", text: $name)
                    .padding()
                    .background(Color.gray.cornerRadius(10))
                    .foregroundColor(.black)
            }
            .padding()
            HStack{
                Text("Items")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                TextField("Enter Name", text: $name)
                    .padding()
                    .background(Color.gray.cornerRadius(10))
                    .foregroundColor(.black)
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .padding(13)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                        
                        .background(.gray)
                        .clipShape(.rect(cornerRadius: 10))
                }

            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    BagsView()
}
