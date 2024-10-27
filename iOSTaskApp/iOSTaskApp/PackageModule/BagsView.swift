//
//  BagsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 21/10/2024.
//

import SwiftUI
import SwiftData

struct BagsView: View {
    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme
    var trip:Trip
    var color:Color
    @Binding var historyView:Bool
    @State var isCollapsed:Bool = true
    @State var showAlert:Bool = false
    @State var bagName:String = ""
    @State var addingBag:Bool = false
    @FocusState private var nameIsFocused : Bool
    
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack{
                VStack(alignment: .center){
                    CustomNavBarModule(module: "Packing", name: "Trip")
                        .padding(.top,30)
                        .frame(width: GeometryProxy.size.width - 30,height: 15)
                }.frame(maxWidth: .infinity)
                VStack(alignment: .center){
                    Text(trip.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Utils.textColor(colorScheme))
                    color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                    VStack{
                        Text(trip.dateFrom , format: .dateTime.day().month().year())
                            .foregroundStyle(Utils.textColor(colorScheme))
                        
                        Text(trip.dateTo , format: .dateTime.day().month().year())
                            .foregroundStyle(Utils.textColor(colorScheme))
                    }.padding(.top,10)
                }
                .frame(maxWidth: .infinity)
                .frame(width: GeometryProxy.size.width - 40)
                if historyView{
                    historyBags
                } else {
                    currentBags
                }
            }.frame(width: GeometryProxy.size.width - 40)
                .frame(maxWidth: .infinity)
            
        }
        
       
        
    }
    @ViewBuilder
    var historyBags: some View {
        
        
        HStack {
            Text("HISTORY:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical,10)
                .foregroundStyle(Utils.textColor(colorScheme))
            Spacer()
        }
        
        
        VStack{
            
            ScrollView{
                VStack{
                    ForEach(trip.bags){ bag in
                        CollapsableBag(colorScheme: colorScheme, bag: bag, color: color, historyView: $historyView, isCollapsed: $isCollapsed, trip: trip)
                            .transition(.move(edge: .bottom))
                        
                    }
                }
            }
            
        }
    }
                
        
            
        
        
    
    
    @ViewBuilder
    var currentBags: some View {
        HStack {
            Text("MY BAGS:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical,10)
                .foregroundStyle(Utils.textColor(colorScheme))
            Spacer()
        }
        
        
        VStack{
            
            ScrollView{
                VStack{
                    ForEach(trip.bags){ bag in
                        CollapsableBag(colorScheme: colorScheme, bag: bag, color: color, historyView: $historyView, isCollapsed: $isCollapsed, trip: trip)
                            .transition(.move(edge: .bottom))
                        
                    }
                }
            }
            
            if isCollapsed {
                collapsed
            }else {
                collapsed.hidden()
                
            }
            
        }
        
        
    }
    @ViewBuilder
    var collapsed: some View {
        HStack{
            TextField("Bag1", text: $bagName)
                .textFieldStyle(.roundedBorder)
                .focused($nameIsFocused)
            
            Button {
                withAnimation {
                    if !trip.validBag(name: bagName){
                        showAlert = true
                        
                    } else{
                        let newBag = Bags(name: bagName, trip: trip)
                        trip.bags.append(newBag)
                        nameIsFocused = false
                        bagName = ""
                    }
                }
                
                
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(color)
                    .clipShape(.rect(cornerRadius: 10))
                
            }.alert("\(trip.alertMessage(name:bagName))" ,isPresented: $showAlert) {
                
            }
            
        }.padding(.bottom,10)
    }
    
    
    
    
    
}

struct ItemCell:View {
    @Environment(\.colorScheme) var colorScheme
    var bag:Bags
    @Binding var historyView:Bool
    let item:Item
    var body: some View {
        ZStack {
            HStack{
                
                Image(systemName:item.marker )
                Text(item.name)
                    .fontWeight(.bold)
                    .foregroundStyle(Utils.textColor(colorScheme))
                if !historyView {
                    Button {
                        if let index = bag.items.firstIndex(of: item){
                            bag.items.remove(at: index)
                        }
                    } label: {
                        Image(systemName: "x.circle")
                    }
                }
                
                
                
                
            }.padding(6)
                .frame(maxWidth: .infinity,alignment: .leading)
            
                .onTapGesture {
                    item.isChecked.toggle()
                }
        }
        
    }
}

struct CollapsableBag:View {
    var colorScheme : ColorScheme
    var bag:Bags
    var color:Color
    @Binding var historyView:Bool
    @Binding var isCollapsed:Bool
    @State var selectedItem:String = ""
    @State var item:Item = Item(name: "",isChecked: false)
    @State var itemName:String = ""
    var trip: Trip
    @FocusState private var itemNameIsFocused : Bool
    var body: some View {
        if historyView {
            historyBags
        }else {
            currentBags
        }
        
    }
    @ViewBuilder
    var historyBags: some View {
        VStack(){
            Button {
                bag.isCollapsed.toggle()
                isCollapsed = bag.isCollapsed
            } label: {
                HStack{
                    Text(bag.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(bag.packedItems)/\(bag.numberOfItems)")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Image(systemName: bag.isCollapsed ? "chevron.down" : "chevron.up")
                        .foregroundStyle(.white)
                        .font(.headline)
                }.padding()
                    .background(color)
                    .clipShape(.rect(cornerRadius: 10))
                
            }
            if bag.isCollapsed {
                VStack {
                }.frame(height: 0)
            }else {
                VStack {
                    VStack{
                        ForEach(bag.items){ item in
                            ItemCell(bag:bag,historyView: $historyView, item: item)
                        }
                        
                        
                    }.padding(.horizontal)
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight:.none)
                    .clipped()
                
                
            }
            
        }.padding(.bottom,10)
    }
    var currentBags: some View {
        VStack(){
            Button {
                bag.isCollapsed.toggle()
                isCollapsed = bag.isCollapsed
            } label: {
                HStack{
                    Text(bag.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(bag.packedItems)/\(bag.numberOfItems)")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Image(systemName: bag.isCollapsed ? "chevron.down" : "chevron.up")
                        .foregroundStyle(.white)
                        .font(.headline)
                }.padding()
                    .background(color)
                    .clipShape(.rect(cornerRadius: 10))
                Button {
                    if let selectedBag = trip.bags.firstIndex(of:bag){
                        trip.bags.remove(at:selectedBag)
                    }
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        .padding(5)
                }
                
            }
            if bag.isCollapsed {
                VStack {
                }.frame(height: 0)
            }else {
                VStack {
                    VStack{
                        ForEach(bag.items){ item in
                            ItemCell(bag:bag,historyView: $historyView, item: item)
                        }
                        
                        HStack {
                            TextField("Item", text: $itemName)
                                .textFieldStyle(.roundedBorder)
                                .focused($itemNameIsFocused)
                            Button {
                                item = Item(name: itemName, isChecked: false)
                                bag.items.append(item)
                                itemNameIsFocused = false
                                itemName = ""
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .padding(2)
                                    .background(color)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width - 120)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        
                    }.padding(.horizontal)
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight:.none)
                    .clipped()
                
                
            }
            
        }.padding(.bottom,10)
    }
    
}


#Preview {
    BagsView(trip: MockData.tripData, color: .orange, historyView: .constant(true))
        .modelContainer(for:[Item.self,Bags.self,PackingModuleDataClass.self])
}
