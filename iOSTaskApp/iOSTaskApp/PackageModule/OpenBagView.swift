//
//  OpenBagView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/11/2024.
//

import SwiftUI

struct OpenBag: View {
    let bag:Bags
    @State var item:Item = Item(name: "",isChecked: false)
    @Environment(\.dismiss) var dismiss
    @FocusState private var itemNameIsFocused : Bool
    @Binding var historyView:Bool
    @State var itemName:String = ""
    var body: some View {
        
        ZStack {
            Color(hex: "22577A")
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack {
                    Button{
                        dismiss()
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                    }
                    Text("ITEMS IN \(bag.name.uppercased())")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    
                }
                ZStack {
                    Color(hex: "FEFAE0")
                        .clipShape(.rect(cornerRadius: 20))
                    
                    VStack{
                        
                        ScrollView(showsIndicators: false){
                            ScrollViewReader { proxy in
                                VStack{
                                    ForEach(bag.items.sorted(by: { Item, _ in
                                        Item.isChecked
                                    }),id: \.name){ item in
                                        ItemCell(bag:bag,historyView: $historyView, item: item)
                                            .padding(.horizontal)
                                            .padding(.bottom,10)
                                        
                                        
                                    }.offset(y: 10)
                                }
                                .onChange(of: bag.items.count) { _,_ in
                                    withAnimation {
                                        proxy.scrollTo(bag.items.last?.id,anchor: .bottom)
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                    }
                }
                
                
                
                
                Spacer()
                if !historyView{
                HStack{
                    TextField("Item", text: $itemName)
                        .padding(10)
                        .frame(height: 40)
                        .foregroundStyle(Color(hex: "22577A"))
                        .background(Color(hex: "FEFAE0"))
                        .clipShape(.rect(cornerRadius: 10))
                        .focused($itemNameIsFocused)
                    
                    
                    
                    
                    Button {
                        withAnimation {
                            
                            let Item = Item(name: itemName, isChecked: false)
                            bag.addItem(a: Item)
                            itemNameIsFocused = false
                            itemName = ""
                        }
                        
                        
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.orange)
                            .clipShape(.rect(cornerRadius: 10))
                        
                    }.sensoryFeedback(.increase, trigger: bag.items.count)
                    
                }.padding(.bottom,10)
            }
            }.padding(.horizontal)
        }
        
        
        
        
        
    }
}
#Preview {
    OpenBag(bag: MockBags.bagA, historyView: .constant(true))
}
