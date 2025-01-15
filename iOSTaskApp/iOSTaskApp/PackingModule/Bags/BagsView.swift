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
    @Environment(\.dismiss) var dismiss
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
                    VStack(alignment: .center,spacing: 5){
                            Color.orange.frame( height: 5)
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

                        
                        if historyView {
                            historyBags
                        } else {
                            currentBags
                        }
                    }
     
                        .frame(width: max(GeometryProxy.size.width - 30,0))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
        } .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
 dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hex: "FEFAE0"))
                    
                }.frame(height: 50)
            }
            ToolbarItem(placement: .principal) {
                Text(trip.name == "" ? NSLocalizedString("trip", comment: "") : trip.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "FEFAE0"))
                    .frame(height: 50)
            }
                    
        }.toolbarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        
        
       
        
    }
    @ViewBuilder
    var historyBags: some View {
        
        
        HStack {
            Text(LocalizedStringKey("my_bags"))
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical,10)
                .foregroundStyle(Color(hex: "FEFAE0"))
            Spacer()
        }
        
        

            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(trip.bags){ bag in
                     
                            ClosedBag(historyView: $historyView, bag: bag,  trip: trip)
                                .transition(.move(edge: .bottom))
     
                        
                        
                        
                    }
                }
            }
        
    
    }
                
        
            
        
        
    
    
    @ViewBuilder
    var currentBags: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("my_bags"))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .foregroundStyle(Color(hex: "FEFAE0"))
                Spacer()
            }
            
            
            
            VStack{
                HStack{
                    TextField(("bag"), text: $bagName)
                        .padding(10)
                        .frame(height: 40)
                        .foregroundStyle(Color(hex: "22577A"))
                        .background(Color(hex: "FEFAE0"))
                        .clipShape(.rect(cornerRadius: 10))
                        .focused($nameIsFocused)
                    
                    
                    
                    
                    Button {
                        withAnimation {
                            if  bagName == "" {
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
                    .alert(LocalizedStringKey("new_bag") ,isPresented: $showAlert) {
                        
                    }.sensoryFeedback(.increase, trigger: trip.bags.count)
                    
                }
                ScrollView(showsIndicators: false){
                    ScrollViewReader{ proxy in
                       
                        ForEach(trip.bags){ bag in
                           
                                ClosedBag(historyView: $historyView, bag: bag, trip: trip)
                                    .transition(.move(edge: .bottom))
      
                            
                        }.onChange(of: trip.bags.count) { _,_ in
                            withAnimation {
                                proxy.scrollTo(trip.bags.last?.id,anchor: .bottom)
                            }
                        }
                    }
                }
                
                
                
            
    
                
                
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
                Spacer()
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
                .frame(maxWidth: .infinity,alignment: .center)
            
                .onTapGesture {
                    if !historyView {
                        
                        item.toggleChecked()
                    }
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
                    
                VStack(spacing:5){
                    HStack{
                            HStack{
                                Text(bag.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "22577A"))
                                Spacer()
                                Text("\(bag.packedItems)/\(bag.numberOfItems)")
                                    .foregroundStyle(Color(hex: "22577A"))
                                    .font(.title3)
                                    .fontWeight(.bold)
                      
                            } .padding(.horizontal)
                     
                        
                        if !historyView {
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
                                Alert(title: Text(LocalizedStringKey("remove_bag")) ,message: Text(LocalizedStringKey("remove_bag_notif")),primaryButton: .destructive(Text("Confirm") ,action: {
                                    trip.removeBags(a: bag)
                                }),secondaryButton: .cancel())
                            }
                        }
                    }.padding(.top)
                    VStack{
                        ForEach(bag.items){
                            item in
                            ItemCell(bag: bag, historyView: $historyView, item: item)
                 
                        }
                    }.padding(10)
                    if !historyView {
                        HStack(spacing:10){
                            TextField(LocalizedStringKey("item"), text: $itemName)
                            
                                .clipShape(.rect(cornerRadius: 10))
                                .focused($itemNameIsFocused)
                                .textFieldStyle(.roundedBorder)
                            
                            
                            
                            
                            
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
                            .padding(.horizontal)
                    }
                    
                }
            }.padding(5)
        }
          
           
        
        
    }
    
}



#Preview {
    BagsView(historyView: .constant(false), trip: MockData.tripData)
        .modelContainer(for:[Item.self,Bags.self,PackingModuleDataClass.self])
}
