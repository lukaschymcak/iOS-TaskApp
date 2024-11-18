//
//  BagsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 21/10/2024.
//

import SwiftUI
import SwiftData

struct BagsView: View {
    @Namespace private var namespace
    @Environment(\.modelContext) var context
    @Binding var historyView:Bool
    var trip:Trip
    @State var showAlert:Bool = false
    @State var bagName:String = ""
    @State var addingBag:Bool = false
    @FocusState private var nameIsFocused : Bool
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(hex: "22577A")
                    .ignoresSafeArea()
                GeometryReader { GeometryProxy in
                    VStack{
                        VStack(alignment: .center){
                            CustomNavBarModule(module: "Packing", name: "Trip")
                            
                                .frame(width: GeometryProxy.size.width - 30,height: 50)
                        }.frame(maxWidth: .infinity)
                        VStack(alignment: .center,spacing: 5){
                            Text(trip.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "FEFAE0"))
                            Color.orange.frame(width: GeometryProxy.size.width - 30, height: 5)
                                .clipShape(.rect(cornerRadius: 20))
                            HStack{
                                Text(trip.dateFrom , format: .dateTime.day().month().year())
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                Text(" - ")
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                Text(trip.dateTo , format: .dateTime.day().month().year())
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                            }.padding(.top,10)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(width: GeometryProxy.size.width - 40)
                        if historyView {
                            historyBags
                        } else {
                            currentBags
                        }
                    }.frame(width: GeometryProxy.size.width - 40)
                        .frame(maxWidth: .infinity)
                    
                }
            }
        }
        
       
        
    }
    @ViewBuilder
    var historyBags: some View {
        
        
        HStack {
            Text("HISTORY:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical,10)
                .foregroundStyle(Color(hex: "FEFAE0"))
            Spacer()
        }
        
        

            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(trip.bags){ bag in
                        NavigationLink {
                           OpenBag(bag: bag, historyView: $historyView)
                                .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            ClosedBag(historyView: $historyView, bag: bag,  trip: trip)
                                .transition(.move(edge: .bottom))
                        }
                        
                        
                        
                    }
                }
            }.padding()
        
    
    }
                
        
            
        
        
    
    
    @ViewBuilder
    var currentBags: some View {
        VStack {
            HStack {
                Text("MY BAGS:")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .foregroundStyle(Color(hex: "FEFAE0"))
                Spacer()
            }
            
            
            
            VStack{
                ScrollView(showsIndicators: false){
                    ScrollViewReader{ proxy in
                        
                        ForEach(trip.bags){ bag in
                            NavigationLink {
                                OpenBag(bag: bag, historyView: $historyView)
                                    .navigationTransition(.zoom(sourceID: "world", in: namespace))
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                ClosedBag(historyView: $historyView, bag: bag, trip: trip)
                                    .transition(.move(edge: .bottom))
                            }
                            
                        }.onChange(of: trip.bags.count) { _,_ in
                            withAnimation {
                                proxy.scrollTo(trip.bags.last?.id,anchor: .bottom)
                            }
                        }
                    }
                }
                
                
                
                    HStack{
                        TextField("Bag1", text: $bagName)
                            .padding(10)
                            .frame(height: 40)
                            .foregroundStyle(Color(hex: "22577A"))
                            .background(Color(hex: "FEFAE0"))
                            .clipShape(.rect(cornerRadius: 10))
                            .focused($nameIsFocused)
                        
                        
                        
                        
                        Button {
                            withAnimation {
                                if !trip.validBag(name: bagName){
                                    showAlert = true
                                    
                                } else{
                                    let newBag = Bags(name: bagName, trip: trip)
                                    trip.addBags(a: newBag)
                                    nameIsFocused = false
                                    bagName = ""
                                }
                            }
                            
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.orange)
                                .clipShape(.rect(cornerRadius: 10))
                            
                        }
                        .alert("\(trip.alertMessage(name:bagName))" ,isPresented: $showAlert) {
                            
                        }.sensoryFeedback(.increase, trigger: trip.bags.count)
                        
                    }.padding(.bottom,10)
                
                
            }
        }
        
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
                    .foregroundStyle(  Color(hex: "22577A"))
                    .font(.title2)
                    .fontWeight(.bold)
                Text(item.name)
                    .fontWeight(.bold)
                    .foregroundStyle(  Color(hex: "22577A"))
                    .font(.title2)
                if !historyView {
                    Button {
                        bag.removeItem(a: item)
                    } label: {
                        Image(systemName: "x.circle")
                            .fontWeight(.bold)
                            .foregroundStyle(  Color(hex: "22577A"))
                            .font(.title2)
                    }
                }
                
                
                
                
            }.padding(4)
                .frame(maxWidth: .infinity,alignment: .leading)
            
                .onTapGesture {
                    item.toggleChecked()
                }.sensoryFeedback(.increase, trigger: bag.items.filter({ Item in
                    item.isChecked
                }).count)
        }
        
    }
}

struct ClosedBag:View {
    @Binding var historyView:Bool
    var bag:Bags
    @State var selectedItem:String = ""
    @State var item:Item = Item(name: "",isChecked: false)
    @State var itemName:String = ""
    @State var showAlert:Bool = false
    var trip: Trip
    @FocusState private var itemNameIsFocused : Bool
    var body: some View {
    
        VStack {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "FEFAE0"))
                    .stroke(Color.orange, lineWidth: 4)
                    .frame(maxHeight:60)
                VStack{
                    HStack{
                            HStack{
                                Text(bag.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "22577A"))
                                Spacer()
                                Text("\(bag.packedItems)/\(bag.numberOfItems)")
                                    .foregroundStyle(Color(hex: "22577A"))
                                    .font(.headline)
                                    .fontWeight(.bold)
                      
                            }.padding()
                     
                        
                        
                        Button {
                            showAlert.toggle()
                        } label: {
                            Image(systemName: "x.circle")
                                .font(.title)
                                .foregroundStyle(Color(hex: "22577A"))
                                .padding(5)
                                .padding(.trailing,12)
                                .fontWeight(.bold)
                            
                        }.alert(isPresented: $showAlert){
                            Alert(title: Text("Remove bag ?") ,message: Text("This will delete the Bag , and your items."),primaryButton: .destructive(Text("Confirm") ,action: {
                                trip.removeBags(a: bag)
                            }),secondaryButton: .cancel())
                        }
                    }
                    
                }
            }.padding(5)
        }
          
           
        
        
    }
    
}

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
                            ForEach(bag.items){ item in
                                ItemCell(bag:bag,historyView: $historyView, item: item)
                                    .padding(.horizontal)
                               
                            }.offset(y: 10)
                            Spacer()
                        }
                    }
                    
                
                
                
                Spacer()
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
            }.padding(.horizontal)
        }
        
        
        
        
        
    }
}


#Preview {
    BagsView(historyView: .constant(false), trip: MockData.tripData)
        .modelContainer(for:[Item.self,Bags.self,PackingModuleDataClass.self])
}
